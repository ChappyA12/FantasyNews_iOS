//
//  PSRotoworldPlayer+CoreDataProperties.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldPlayer+CoreDataClass.h"

@interface PSRotoworldPlayer (CoreDataProperties)

+ (NSFetchRequest<PSRotoworldPlayer *> *)fetchRequest;

@property (nonatomic) int32_t playerID;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *position;
@property (nullable, nonatomic, copy) NSString *teamID;
@property (nullable, nonatomic, copy) NSDate *birthday;
@property (nullable, nonatomic, retain) PSRotoworldTeam *team;
@property (nullable, nonatomic, retain) NSSet<PSRotoworldNews *> *news;
@property (nullable, nonatomic, retain) PSFantasyPlayer *fantasy;

@end

@interface PSRotoworldPlayer (CoreDataGeneratedAccessors)

- (void)addNewsObject:(PSRotoworldNews *)value;
- (void)removeNewsObject:(PSRotoworldNews *)value;
- (void)addNews:(NSSet<PSRotoworldNews *> *)values;
- (void)removeNews:(NSSet<PSRotoworldNews *> *)values;

@end
