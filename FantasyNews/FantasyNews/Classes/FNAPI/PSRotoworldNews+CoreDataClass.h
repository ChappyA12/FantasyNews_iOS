//
//  PSRotoworldNews+CoreDataClass.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSRotoworldPlayer;

@interface PSRotoworldNews : NSManagedObject

+ (void)saveRecentNews:(void(^)(BOOL success))completion;

+ (void)saveRecentNewsForPlayerID:(NSInteger)playerID
                       completion:(void(^)(BOOL success))completion;

+ (NSArray<PSRotoworldNews *> *)newsForQuery:(NSString *)searchString;

+ (PSRotoworldNews *)newsForArticleID:(NSInteger)articleID;

@end

#import "PSRotoworldNews+CoreDataProperties.h"
