//
//  PSFantasyTeam+CoreDataProperties.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSFantasyTeam+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSFantasyTeam (CoreDataProperties)

+ (NSFetchRequest<PSFantasyTeam *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *teamFullID;
@property (nullable, nonatomic, copy) NSString *type;
@property (nonatomic) int32_t teamID;
@property (nonatomic) int32_t leagueID;
@property (nonatomic) int32_t seasonID;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *abbrev;
@property (nullable, nonatomic, copy) NSString *logoType;
@property (nullable, nonatomic, copy) NSString *logoLink;
@property (nullable, nonatomic, copy) NSString *leagueName;
@property (nullable, nonatomic, copy) NSString *entryLink;
@property (nullable, nonatomic, copy) NSString *scoreboardLink;
@property (nonatomic) int32_t wins;
@property (nonatomic) int32_t losses;
@property (nonatomic) int32_t ties;
@property (nonatomic) int32_t points;
@property (nonatomic) int32_t rank;
@property (nonatomic) int32_t gameID;
@property (nonatomic) int32_t scoringPeriodID;
@property (nullable, nonatomic, retain) PSFantasyUser *user;
@property (nullable, nonatomic, retain) NSSet<PSFantasyPlayer *> *players;

@end

@interface PSFantasyTeam (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(PSFantasyPlayer *)value;
- (void)removePlayersObject:(PSFantasyPlayer *)value;
- (void)addPlayers:(NSSet<PSFantasyPlayer *> *)values;
- (void)removePlayers:(NSSet<PSFantasyPlayer *> *)values;

@end

NS_ASSUME_NONNULL_END
