//
//  PSFantasyTeam+CoreDataProperties.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSFantasyTeam+CoreDataProperties.h"

@implementation PSFantasyTeam (CoreDataProperties)

+ (NSFetchRequest<PSFantasyTeam *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PSFantasyTeam"];
}

@dynamic teamFullID;
@dynamic type;
@dynamic teamID;
@dynamic leagueID;
@dynamic seasonID;
@dynamic firstName;
@dynamic lastName;
@dynamic abbrev;
@dynamic logoType;
@dynamic logoLink;
@dynamic leagueName;
@dynamic entryLink;
@dynamic scoreboardLink;
@dynamic wins;
@dynamic losses;
@dynamic ties;
@dynamic points;
@dynamic rank;
@dynamic gameID;
@dynamic scoringPeriodID;
@dynamic user;
@dynamic players;

@end
