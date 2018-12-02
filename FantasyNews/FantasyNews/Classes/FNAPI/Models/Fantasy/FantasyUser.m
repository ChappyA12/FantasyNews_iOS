//
//  FantasyUser.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/1/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FantasyUser.h"

@implementation FantasyGroup

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"groupID": @"groupId",
        @"name": @"groupName",
        @"size": @"groupSize",
        @"wins": @"wins",
        @"losses": @"losses",
        @"ties": @"ties",
        @"points": @"points",
        @"rank": @"rank"
    }];
}

- (BOOL)isEqual:(FantasyGroup *)other {
    return self.groupID == other.groupID;
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
        @"logoURL": @"metaData.entry.logoUrl",
        @"entryURL": @"metaData.entry.entryURL",
        @"scoreboardURL": @"metaData.entry.scoreboardFeedURL",
        @"groups": @"metaData.entry.groups"
    }];
}

- (BOOL)isEqual:(FantasyTeam *)other {
    return [self.teamFullID isEqualToString:other.teamFullID];
}

- (NSInteger)leagueID {
    return ([self inLeague]) ? self.groups[0].groupID : -1;
}

- (NSString<Ignore> *)leagueName {
    return ([self inLeague]) ? self.groups[0].name : nil;
}

- (NSString<Ignore> *)record {
    return ([self inLeague]) ?
        [NSString stringWithFormat:@"%ld-%ld", self.groups[0].wins, self.groups[0].losses] : @"-";
}

- (BOOL)inLeague {
    return self.groups[0];
}

@end



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
