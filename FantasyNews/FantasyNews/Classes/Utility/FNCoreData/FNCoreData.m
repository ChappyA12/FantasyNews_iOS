//
//  FNCoreData.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/4/18.
//  Copyright © 2018 CD. All rights reserved.
//

#import "FNCoreData.h"

NSString *const FNCoreDataDidSaveNotification = @"FNCoreDataDidSaveNotification";
NSString *const FNCoreDataDidSaveFailedNotification = @"FNCoreDataDidSaveFailedNotification";

@interface FNCoreData()
@property (nonatomic) NSURL *applicationGroupDirectory;
@end

@implementation FNCoreData

NSString *const kDataManagerGroupName = @"group.com.chappyasel.fantasynews";
NSString *const kDataManagerBundleName = @"com.chappyasel.fantasynews";
NSString *const kDataManagerModelName = @"FantasyNews";
NSString *const kDataManagerSQLiteName = @"FantasyNews.sqlite";

@synthesize psCoordinator = _psCoordinator;
@synthesize context = _context;
@synthesize model = _model;

+ (FNCoreData *)sharedInstance {
    static dispatch_once_t pred;
    static FNCoreData *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/// The directory the application uses to store the Core Data store file. This code uses a directory named
/// "CDdesigns.Homework" in the application's documents directory.
- (NSURL *)applicationGroupDirectory {
    return [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kDataManagerGroupName];
}

/// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
- (NSManagedObjectModel *)model {
    if (_model) return _model;
    NSString *modelPath = [NSBundle.mainBundle pathForResource:kDataManagerModelName ofType:@"momd"];
    _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];
    return _model;
}

/// The persistent store coordinator for the application. This implementation creates and
/// returns a coordinator, having added the store for the application to it.
- (NSPersistentStoreCoordinator *)psCoordinator {
    if (_psCoordinator) return _psCoordinator;
    
    NSURL *storeURL = [self.applicationGroupDirectory URLByAppendingPathComponent:kDataManagerSQLiteName];
    _psCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    
    if (![self migrateDataIfNessesaryWithNewStoreUrl:storeURL]) {
        NSError *error;
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES, NSInferMappingModelAutomaticallyOption: @YES};
        if (![_psCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                          configuration:nil URL:storeURL
                                                options:options error:&error]) {
            NSLog(@"Persistent store error");
            abort();
        }
    }
    return _psCoordinator;
}

/// Returns the managed object context for the application
- (NSManagedObjectContext *)context {
    if (_context) return _context;
    
    NSPersistentStoreCoordinator *coordinator = [self psCoordinator];
    if (!coordinator) return nil;
    
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:coordinator];
    return _context;
}

/// Saves the managed object context, processing the error otherwize
- (BOOL)save {
    if (![self.context hasChanges]) return YES;
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"Error while saving: %@\n%@", [error localizedDescription], [error userInfo]);
        [[NSNotificationCenter defaultCenter] postNotificationName:FNCoreDataDidSaveFailedNotification
                                                            object:error];
        return NO;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:FNCoreDataDidSaveNotification object:nil];
    return YES;
}

/// If data is present in the existing directory and not in the new one, move it to the new directory and delete existing
- (BOOL)migrateDataIfNessesaryWithNewStoreUrl:(NSURL *)newURL {
    NSURL *oldURL = [[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject
                     URLByAppendingPathComponent:@"Homework.sqlite"];
    if ([NSFileManager.defaultManager fileExistsAtPath:oldURL.path] &&
        ![NSFileManager.defaultManager fileExistsAtPath:newURL.path]) {
        NSError *error;
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES, NSInferMappingModelAutomaticallyOption: @YES};
        if (![_psCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
                                                    URL:oldURL options:options error:&error]) {
            NSLog(@"Persistent store migration error: init");
            abort();
        }
        NSPersistentStore *store = [_psCoordinator persistentStoreForURL:oldURL];
        if (![_psCoordinator migratePersistentStore:store toURL:newURL options:options
                                           withType:NSSQLiteStoreType error:&error]) {
            NSLog(@"Persistent store migration error: move");
            abort();
        }
        [self deleteStoreAtUrl:oldURL];
        NSLog(@"Data successfully migrated");
        return YES;
    }
    return NO;
}

- (void)deleteStoreAtUrl:(NSURL *)url {
    NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] init];
    [coordinator coordinateWritingItemAtURL:url options:NSFileCoordinatorWritingForDeleting
                                      error:nil byAccessor:^(NSURL *newURL) {
        NSError *error;
        [NSFileManager.defaultManager removeItemAtURL:newURL error:&error];
        if (error) {
            NSLog(@"Deleting store error");
        }
    }];
}

//#pragma mark - Notification Observers
//- (void)registerForiCloudNotifications {
//    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
//
//    [notificationCenter addObserver:self
//                           selector:@selector(storesWillChange:)
//                               name:NSPersistentStoreCoordinatorStoresWillChangeNotification
//                             object:self.persistentStoreCoordinator];
//
//    [notificationCenter addObserver:self
//                           selector:@selector(storesDidChange:)
//                               name:NSPersistentStoreCoordinatorStoresDidChangeNotification
//                             object:self.persistentStoreCoordinator];
//
//    [notificationCenter addObserver:self
//                           selector:@selector(persistentStoreDidImportUbiquitousContentChanges:)
//                               name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
//                             object:self.persistentStoreCoordinator];
//}
//
//# pragma mark - iCloud Support
//
///// Use these options in your call to -addPersistentStore:
//- (NSDictionary *)iCloudPersistentStoreOptions {
//    return @{NSPersistentStoreUbiquitousContentNameKey: @"MyAppStore"};
//}
//
//- (void) persistentStoreDidImportUbiquitousContentChanges:(NSNotification *)changeNotification {
//    NSManagedObjectContext *context = self.managedObjectContext;
//
//    [context performBlock:^{
//        [context mergeChangesFromContextDidSaveNotification:changeNotification];
//    }];
//}
//
//- (void)storesWillChange:(NSNotification *)notification {
//    NSManagedObjectContext *context = self.managedObjectContext;
//
//    [context performBlockAndWait:^{
//        NSError *error;
//
//        if ([context hasChanges]) {
//            BOOL success = [context save:&error];
//
//            if (!success && error) {
//                // perform error handling
//                NSLog(@"%@",[error localizedDescription]);
//            }
//        }
//
//        [context reset];
//    }];
//
//    // Refresh your User Interface.
//}
//
//- (void)storesDidChange:(NSNotification *)notification {
//    // Refresh your User Interface.
//}

@end
