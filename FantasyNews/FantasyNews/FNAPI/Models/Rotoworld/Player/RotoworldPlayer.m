//
//  RotoworldPlayer.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "RotoworldPlayer.h"

@implementation RotoworldPlayer

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"playerID": @"PLAYERID",
        @"firstName": @"FIRSTNAME",
        @"lastName": @"LASTNAME",
        @"position": @"MAJPOSIT",
        @"team": @"MAJTEAM",
        @"birthday": @"BIRTHDATE"
    }];
}

- (BOOL)isEqual:(RotoworldPlayer *)other {
    return self.playerID == other.playerID;
}

@end
