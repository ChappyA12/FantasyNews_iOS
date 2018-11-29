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

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSString *)teamPosition {
    return [NSString stringWithFormat:@"%@ | %@", self.team, self.position];
}

- (NSURL *)imageURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.rotoworld.com/images/headshots/NBA/%ld.jpg", self.playerID]];
}

@end
