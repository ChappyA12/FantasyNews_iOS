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
    if (self.espnID != -1)
        return [NSURL URLWithString:[NSString stringWithFormat:
             @"http://a.espncdn.com/combiner/i?img=/i/headshots/NBA/players/full/%d.png&w=426&h=310", self.espnID]];
    return [NSURL URLWithString:[NSString stringWithFormat:
             @"http://www.rotoworld.com/images/headshots/NBA/%d.jpg", self.rotoworldID]];
}


+ (void)saveAllPlayers:(void(^)(BOOL success))completion {
    [FNAPI.rotoworld players:^(NSArray<RotoworldPlayer *> *players) {
        [FNAPI.fantasy playerMappingDictsForSeasonID:2019
                                          completion:^(NSDictionary *first, NSDictionary *last, NSDictionary *firstLast) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (RotoworldPlayer *player in players) {
                    NSInteger espnID = -1;
                    NSArray *full = [firstLast objectForKey:player.fullName];
                    if (full && full.count == 1) {
                        espnID = [full.firstObject intValue];
                    } else {
                        NSArray *lastName = [last objectForKey:player.lastName];
                        if (lastName && lastName.count == 1) {
                            espnID = [lastName.firstObject intValue];
                        } else {
                            NSArray *firstName = [first objectForKey:player.firstName];
                            if (firstName && firstName.count == 1) {
                                espnID = [firstName.firstObject intValue];
                            }
                        }
                    }
                    [self persistentPlayerforPlayer:player withEspnID:espnID];
                }
                NSLog(@"Added Players");
                [FNCoreData.sharedInstance save];
                completion(YES);
            });
        }];
    }];
}

+ (NSArray<PSRotoworldPlayer *> *)playersForQuery:(NSString *)searchString {
    NSFetchRequest *request = [PSRotoworldPlayer fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"firstName OR lastName CONTAINS[cd] %@", searchString];
    return [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
}

+ (PSRotoworldPlayer *)playerForRotoworldID:(NSInteger)rotoworldID {
    NSFetchRequest *request = [PSRotoworldPlayer fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"rotoworldID = %ld", rotoworldID];
    NSArray *result = [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
    return (result.count) ? result.firstObject : nil;
}

+ (PSRotoworldPlayer *)persistentPlayerforPlayer:(RotoworldPlayer *)player {
    return [self persistentPlayerforPlayer:player withEspnID:-1];
}

#pragma mark - private helper methods

+ (PSRotoworldPlayer *)persistentPlayerforPlayer:(RotoworldPlayer *)player withEspnID:(NSInteger)espnID {
    NSManagedObjectContext *context = FNCoreData.sharedInstance.context;
    PSRotoworldPlayer *psPlayer = [self playerForRotoworldID:player.playerID];
    if (!psPlayer) {
        psPlayer = [NSEntityDescription insertNewObjectForEntityForName:@"PSRotoworldPlayer"
                                                 inManagedObjectContext:context];
    }
    psPlayer.rotoworldID = (int32_t)player.playerID;
    psPlayer.espnID = (int32_t)espnID;
    psPlayer.firstName = player.firstName;
    psPlayer.lastName = player.lastName;
    psPlayer.position = player.position;
    psPlayer.birthday = player.birthday;
    if (psPlayer.teamID != player.team) {
        psPlayer.teamID = player.team;
        PSRotoworldTeam *team = [PSRotoworldTeam teamForTeamID:player.team];
        if (team) {
            psPlayer.team = team;
            [team addPlayersObject:psPlayer];
        }
    }
    return psPlayer;
}

@end
