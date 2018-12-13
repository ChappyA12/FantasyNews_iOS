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
        dispatch_async(dispatch_get_main_queue(), ^{
            for (RotoworldTeam *team in teams)
                [self persistentTeamforTeam:team];
        });
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
    PSRotoworldTeam *psTeam = [self teamForTeamID:team.teamID];
    if (!psTeam) {
        psTeam = [NSEntityDescription insertNewObjectForEntityForName:@"PSRotoworldTeam"
                                               inManagedObjectContext:context];
        NSLog(@"Added PSRotoworldTeam: %@", team.teamID);
    }
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
