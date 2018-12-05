//
//  PSFantasyUser+CoreDataProperties.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSFantasyUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSFantasyUser (CoreDataProperties)

+ (NSFetchRequest<PSFantasyUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userID;
@property (nullable, nonatomic, retain) NSSet<PSFantasyTeam *> *teams;

@end

@interface PSFantasyUser (CoreDataGeneratedAccessors)

- (void)addTeamsObject:(PSFantasyTeam *)value;
- (void)removeTeamsObject:(PSFantasyTeam *)value;
- (void)addTeams:(NSSet<PSFantasyTeam *> *)values;
- (void)removeTeams:(NSSet<PSFantasyTeam *> *)values;

@end

NS_ASSUME_NONNULL_END
