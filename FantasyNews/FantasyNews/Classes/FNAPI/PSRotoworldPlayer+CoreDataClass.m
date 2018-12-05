//
//  PSRotoworldPlayer+CoreDataClass.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldPlayer+CoreDataClass.h"
#import "FNAPI.h"
#import "FNCoreData.h"

@implementation PSRotoworldPlayer

+ (void)saveAllPlayers {
    [FNAPI.rotoworld players:^(NSArray<RotoworldPlayer *> *players) {
        for (RotoworldPlayer *player in players) {
            if (![self playerForRotoworldID:player.playerID]) {
                [self persistentPlayerforPlayer:player];
                NSLog(@"Added %@", player.fullName);
            }
        }
        [FNCoreData.sharedInstance save];
    }];
}

+ (NSArray<PSRotoworldPlayer *> *)playersForQuery:(NSString *)searchString {
    NSFetchRequest *request = [PSRotoworldPlayer fetchRequest];
    request.predicate =
        [NSPredicate predicateWithFormat:@"firstName OR lastName CONTAINS[cd] %@", searchString];
    NSArray *result = [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
    return (result.count) ? result.firstObject : nil;
}

+ (PSRotoworldPlayer *)playerForRotoworldID:(NSInteger)rotoworldID {
    NSFetchRequest *request = [PSRotoworldPlayer fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"playerID = %ld", rotoworldID];
    NSArray *result = [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
    return (result.count) ? result.firstObject : nil;
}

#pragma mark - private helper methods

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
    psPlayer.team = nil;
    psPlayer.news = nil;
    psPlayer.fantasy = nil;
    return psPlayer;
}

@end
