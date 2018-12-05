//
//  PSRotoworldTeam+CoreDataClass.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSObject, PSRotoworldPlayer, RotoworldTeam;

@interface PSRotoworldTeam : NSManagedObject

@property (nonatomic) NSString *fullName;

+ (void)saveAllTeams:(void(^)(BOOL success))completion;

+ (NSArray<PSRotoworldTeam *> *)teamsForQuery:(NSString *)searchString;

+ (PSRotoworldTeam *)teamForTeamID:(NSString *)teamID;

+ (PSRotoworldTeam *)persistentTeamforTeam:(RotoworldTeam *)team;

@end

#import "PSRotoworldTeam+CoreDataProperties.h"
