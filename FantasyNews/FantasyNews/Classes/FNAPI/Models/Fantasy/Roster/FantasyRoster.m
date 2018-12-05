//
//  FantasyRoster.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/4/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FantasyRoster.h"

@implementation FantasyRoster

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"teamID": @"team.id",
        @"leagueID": @"id",
        @"seasonID": @"seasonId",
        @"gameID": @"gameId",
        @"scoringPeriodID": @"scoringPeriodId",
        @"players": @"team.roster.entries"
    }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    NSMutableDictionary *teams = dict.mutableCopy;
    teams[@"team"] = teams[@"teams"][0];
    self = [super initWithDictionary:teams error:err];
    return self;
}

- (BOOL)isEqual:(FantasyRoster *)other {
    return self.teamID == other.teamID &&
           self.leagueID == other.leagueID;
}

@end



@implementation FantasyPlayer

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"rotoworldID": @"playerId",
        @"espnID": @"playerId",
        @"firstName": @"playerPoolEntry.player.firstName",
        @"lastName": @"playerPoolEntry.player.lastName",
        @"jerseyNumber": @"playerPoolEntry.player.jersey"
    }];
}

- (BOOL)isEqual:(FantasyPlayer *)other {
    return self.espnID == other.espnID;
}

@end
