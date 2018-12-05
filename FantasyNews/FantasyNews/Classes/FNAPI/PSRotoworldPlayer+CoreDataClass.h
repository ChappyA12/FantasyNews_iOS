//
//  PSRotoworldPlayer+CoreDataClass.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSFantasyPlayer, PSRotoworldNews, PSRotoworldTeam;

@interface PSRotoworldPlayer : NSManagedObject

+ (void)saveAllPlayers;

+ (NSArray<PSRotoworldPlayer *> *)playersForQuery:(NSString *)searchString;

+ (PSRotoworldPlayer *)playerForRotoworldID:(NSInteger)rotoworldID;

@end

#import "PSRotoworldPlayer+CoreDataProperties.h"
