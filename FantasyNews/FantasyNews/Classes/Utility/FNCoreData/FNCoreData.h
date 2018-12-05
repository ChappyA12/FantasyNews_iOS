//
//  FNCoreData.h
//  FantasyNews
//
//  Created by Chappy Asel on 12/4/18.
//  Copyright © 2018 CD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern NSString *const FNCoreDataDidSaveNotification;
extern NSString *const FNCoreDataDidSaveFailedNotification;

@interface FNCoreData : NSObject

@property (nonatomic, readonly, strong) NSManagedObjectContext *context;
@property (nonatomic, readonly, retain) NSManagedObjectModel *model;
@property (nonatomic, readonly, retain) NSPersistentStoreCoordinator *psCoordinator;

+ (FNCoreData *)sharedInstance;

- (BOOL)save;

@end
