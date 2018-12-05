//
//  FantasyUser.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/1/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FantasyUser.h"

@implementation FantasyUser

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"userID": @"id",
        @"teams": @"preferences"
    }];
}

- (BOOL)isEqual:(FantasyUser *)other {
    return self.userID == other.userID;
}

@end



@implementation FantasyTeam

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"teamFullID": @"id",
        @"type": @"metaData.entry.abbrev",
        @"teamID": @"metaData.entry.entryId",
        @"leagueID": @"id",
        @"seasonID": @"metaData.entry.seasonId",
        @"firstName": @"metaData.entry.entryLocation",
        @"lastName": @"metaData.entry.entryNickname",
        @"abbrev": @"metaData.entry.entryMetadata.teamAbbrev",
        @"logoType": @"metaData.entry.logoType",
        @"logoLink": @"metaData.entry.logoUrl",
        @"entryLink": @"metaData.entry.entryURL",
        @"scoreboardLink": @"metaData.entry.scoreboardFeedURL",
        @"leagueName": @"group.groupName",
        @"leagueSize": @"group.groupSize",
        @"wins": @"group.wins",
        @"losses": @"group.losses",
        @"ties": @"group.ties",
        @"points": @"group.points",
        @"rank": @"group.rank"
    }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    NSMutableDictionary *team = dict.mutableCopy;
    team[@"group"] = team[@"metaData"][@"entry"][@"groups"][0];
    self = [super initWithDictionary:team error:err];
    return self;
}

- (BOOL)isEqual:(FantasyTeam *)other {
    return [self.teamFullID isEqualToString:other.teamFullID];
}

@end
