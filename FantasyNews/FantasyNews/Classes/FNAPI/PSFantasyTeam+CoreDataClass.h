//
//  PSFantasyTeam+CoreDataClass.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSFantasyPlayer, PSFantasyUser, FantasyTeam;

@interface PSFantasyTeam : NSManagedObject

+ (PSFantasyTeam *)persistentTeamforTeam:(FantasyTeam *)team;

@end

#import "PSFantasyTeam+CoreDataProperties.h"
