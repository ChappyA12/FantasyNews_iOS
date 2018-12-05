//
//  PSRotoworldPlayer+CoreDataClass.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSFantasyPlayer, PSRotoworldNews, PSRotoworldTeam, RotoworldPlayer;

@interface PSRotoworldPlayer : NSManagedObject

@property (nonatomic) NSString *fullName;
@property (nonatomic) NSString *fullTeamPosition;
@property (nonatomic) NSString *teamPosition;
@property (nonatomic) NSURL *imageURL;

+ (void)saveAllPlayers:(void(^)(BOOL success))completion;

+ (NSArray<PSRotoworldPlayer *> *)playersForQuery:(NSString *)searchString;

+ (PSRotoworldPlayer *)playerForRotoworldID:(NSInteger)rotoworldID;

+ (PSRotoworldPlayer *)persistentPlayerforPlayer:(RotoworldPlayer *)player;

@end

#import "PSRotoworldPlayer+CoreDataProperties.h"
