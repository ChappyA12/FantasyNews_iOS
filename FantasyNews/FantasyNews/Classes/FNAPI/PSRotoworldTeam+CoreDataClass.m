//
//  PSRotoworldTeam+CoreDataClass.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldTeam+CoreDataClass.h"
#import "FNCoreData.h"
#import "FNAPI.h"

@implementation PSRotoworldTeam

@dynamic fullName;

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.city, self.name];
}

+ (void)saveAllTeams:(void(^)(BOOL success))completion {
    [FNAPI.rotoworld teams:^(NSArray<RotoworldTeam *> *teams) {
        for (RotoworldTeam *team in teams) {
            if (![self teamForTeamID:team.teamID]) {
                [self persistentTeamforTeam:team];
                NSLog(@"Added %@", team.teamID);
            }
        }
        [FNCoreData.sharedInstance save];
        completion(YES);
    }];
}

+ (NSArray<PSRotoworldTeam *> *)teamsForQuery:(NSString *)searchString {
    NSFetchRequest *request = [PSRotoworldTeam fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"city OR name CONTAINS[cd] %@", searchString];
    return [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
}

+ (PSRotoworldTeam *)teamForTeamID:(NSString *)teamID {
    NSFetchRequest *request = [PSRotoworldTeam fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"teamID = %@", teamID];
    NSArray *result = [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
    return (result.count) ? result.firstObject : nil;
}

+ (PSRotoworldTeam *)persistentTeamforTeam:(RotoworldTeam *)team {
    NSManagedObjectContext *context = FNCoreData.sharedInstance.context;
    PSRotoworldTeam *psTeam = [NSEntityDescription insertNewObjectForEntityForName:@"PSRotoworldTeam"
                                                            inManagedObjectContext:context];
    psTeam.teamID = team.teamID;
    psTeam.city = team.city;
    psTeam.name = team.name;
    psTeam.rawColor = [NSKeyedArchiver archivedDataWithRootObject:team.color];
    psTeam.conference = team.conference;
    psTeam.division = team.division;
    psTeam.official = team.official;
    return psTeam;
}

@end
