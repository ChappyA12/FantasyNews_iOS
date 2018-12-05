//
//  PSFantasyUser+CoreDataClass.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSFantasyTeam, FantasyUser;

@interface PSFantasyUser : NSManagedObject

+ (PSFantasyUser *)persistentUserWithUserID:(NSString *)userID;

+ (PSFantasyUser *)persistentUserforUser:(FantasyUser *)user;

@end

#import "PSFantasyUser+CoreDataProperties.h"
