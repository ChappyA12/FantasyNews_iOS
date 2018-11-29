//
//  RotoworldTeam.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "RotoworldTeam.h"

@implementation RotoworldTeam

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"teamID": @"MAJTEAM",
        @"city": @"CITY",
        @"name": @"TEAMNAME",
        @"color": @"TEAMCOLOR1",
        @"conference": @"CONFNAME",
        @"division": @"DIVNAME",
        @"official": @"ISOFFICIAL"
    }];
}

- (BOOL)isEqual:(RotoworldTeam *)other {
    return [self.teamID isEqualToString:other.teamID];
}

@end
