//
//  PSFantasyUser+CoreDataClass.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSFantasyUser+CoreDataClass.h"
#import "PSFantasyTeam+CoreDataClass.h"
#import "FantasyUser.h"
#import "FNCoreData.h"

@implementation PSFantasyUser

+ (PSFantasyUser *)persistentUserWithUserID:(NSString *)userID {
    NSFetchRequest *request = [PSFantasyUser fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"userID = %ld", userID];
    NSArray *result = [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
    return (result.count) ? result.firstObject : nil;
}

+ (PSFantasyUser *)persistentUserforUser:(FantasyUser *)user {
    NSManagedObjectContext *context = FNCoreData.sharedInstance.context;
    PSFantasyUser *psUser = [NSEntityDescription insertNewObjectForEntityForName:@"PSFantasyUser"
                                                          inManagedObjectContext:context];
    psUser.userID = user.userID;
    for (FantasyTeam *team in user.teams) {
        PSFantasyTeam *psTeam = [PSFantasyTeam persistentTeamforTeam:team];
        [psUser addTeamsObject:psTeam];
        psTeam.user = psUser;
    }
    return psUser;
}

@end
