//
//  PSRotoworldTeam+CoreDataProperties.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldTeam+CoreDataClass.h"

@interface PSRotoworldTeam (CoreDataProperties)

+ (NSFetchRequest<PSRotoworldTeam *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *teamID;
@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSObject *rawColor;
@property (nullable, nonatomic, copy) NSString *conference;
@property (nullable, nonatomic, copy) NSString *division;
@property (nonatomic) BOOL official;
@property (nullable, nonatomic, retain) NSSet<PSRotoworldPlayer *> *players;

@end

@interface PSRotoworldTeam (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(PSRotoworldPlayer *)value;
- (void)removePlayersObject:(PSRotoworldPlayer *)value;
- (void)addPlayers:(NSSet<PSRotoworldPlayer *> *)values;
- (void)removePlayers:(NSSet<PSRotoworldPlayer *> *)values;

@end
