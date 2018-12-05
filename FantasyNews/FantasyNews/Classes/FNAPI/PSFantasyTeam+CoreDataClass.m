//
//  PSFantasyTeam+CoreDataClass.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSFantasyTeam+CoreDataClass.h"
#import "FantasyUser.h"
#import "FNCoreData.h"

@implementation PSFantasyTeam

+ (PSFantasyTeam *)persistentTeamforTeam:(FantasyTeam *)team {
    NSManagedObjectContext *context = FNCoreData.sharedInstance.context;
    PSFantasyTeam *psTeam = [NSEntityDescription insertNewObjectForEntityForName:@"PSFantasyTeam"
                                                          inManagedObjectContext:context];
    psTeam.teamFullID = team.teamFullID;
    psTeam.type = team.type;
    psTeam.teamID = (int32_t)team.teamID;
    psTeam.leagueID = (int32_t)team.leagueID;
    psTeam.seasonID = (int32_t)team.seasonID;
    psTeam.firstName = team.firstName;
    psTeam.lastName = team.lastName;
    psTeam.abbrev = team.abbrev;
    psTeam.logoType = team.logoType;
    psTeam.logoLink = team.logoLink;
    psTeam.leagueName = team.leagueName;
    psTeam.entryLink = team.entryLink;
    psTeam.scoreboardLink = team.scoreboardLink;
    psTeam.wins = (int32_t)team.wins;
    psTeam.losses = (int32_t)team.losses;
    psTeam.ties = (int32_t)team.ties;
    psTeam.points = (int32_t)team.points;
    psTeam.rank = (int32_t)team.rank;
//    psTeam.gameID = (int32_t)XXX;
//    psTeam.scoringPeriodID = (int32_t)XXX;
    return psTeam;
}

@end
