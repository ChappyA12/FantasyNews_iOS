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
        @"name": @"groupName"
    }];
}

- (BOOL)isEqual:(FantasyTeam *)other {
    return self.groupID == other.groupID;
}

@end



@implementation FantasyTeam

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"teamFullID": @"id",
        @"type": @"metaData.entry.abbrev",
        @"teamID": @"metaData.entry.entryId",
        @"groupID": @"id",
        @"seasonID": @"metaData.entry.seasonId",
        @"firstName": @"metaData.entry.entryLocation",
        @"lastName": @"metaData.entry.entryNickname",
        @"abbrev": @"metaData.entry.entryMetadata.teamAbbrev",
        @"logoType": @"metaData.entry.logoType",
        @"logoURL": @"metaData.entry.logoUrl",
        @"groups": @"metaData.entry.groups"
    }];
}

- (BOOL)isEqual:(FantasyTeam *)other {
    return self.teamFullID == other.teamFullID;
}

- (NSInteger)groupID {
    if (self.groups[0])
        return self.groups[0].groupID;
    return -1;
}

- (NSString<Ignore> *)groupName {
    if (self.groups[0])
        return self.groups[0].name;
    return nil;
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
