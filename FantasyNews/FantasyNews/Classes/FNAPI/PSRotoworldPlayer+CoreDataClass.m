//
//  PSRotoworldPlayer+CoreDataClass.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldPlayer+CoreDataClass.h"
#import "PSRotoworldTeam+CoreDataClass.h"
#import "FNAPI.h"
#import "FNCoreData.h"

@implementation PSRotoworldPlayer

@dynamic fullName;
@dynamic fullTeamPosition;
@dynamic teamPosition;
@dynamic imageURL;

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSString *)fullTeamPosition {
    return [NSString stringWithFormat:@"%@ | %@", self.team.fullName, self.position];
}

- (NSString *)teamPosition {
    return [NSString stringWithFormat:@"%@ | %@", self.teamID, self.position];
}

- (NSURL *)imageURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.rotoworld.com/images/headshots/NBA/%d.jpg", self.playerID]];
}


+ (void)saveAllPlayers:(void(^)(BOOL success))completion {
    [FNAPI.rotoworld players:^(NSArray<RotoworldPlayer *> *players) {
        for (RotoworldPlayer *player in players) {
            if (![self playerForRotoworldID:player.playerID]) {
                [self persistentPlayerforPlayer:player];
                NSLog(@"Added %@", player.fullName);
            }
        }
        [FNCoreData.sharedInstance save];
        completion(YES);
    }];
}

+ (NSArray<PSRotoworldPlayer *> *)playersForQuery:(NSString *)searchString {
    NSFetchRequest *request = [PSRotoworldPlayer fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"firstName OR lastName CONTAINS[cd] %@", searchString];
    return [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
}

+ (PSRotoworldPlayer *)playerForRotoworldID:(NSInteger)rotoworldID {
    NSFetchRequest *request = [PSRotoworldPlayer fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"playerID = %ld", rotoworldID];
    NSArray *result = [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
    return (result.count) ? result.firstObject : nil;
}

+ (PSRotoworldPlayer *)persistentPlayerforPlayer:(RotoworldPlayer *)player {
    NSManagedObjectContext *context = FNCoreData.sharedInstance.context;
    PSRotoworldPlayer *psPlayer =
        [NSEntityDescription insertNewObjectForEntityForName:@"PSRotoworldPlayer"
                                      inManagedObjectContext:context];
    psPlayer.playerID = (int32_t)player.playerID;
    psPlayer.firstName = player.firstName;
    psPlayer.lastName = player.lastName;
    psPlayer.position = player.position;
    psPlayer.teamID = player.team;
    psPlayer.birthday = player.birthday;
    PSRotoworldTeam *team = [PSRotoworldTeam teamForTeamID:player.team];
    if (team) {
        psPlayer.team = team;
        [team addPlayersObject: psPlayer];
    }
    return psPlayer;
}

@end
