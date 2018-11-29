//
//  RotoworldNews.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "RotoworldNews.h"

@implementation RotoworldNews

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"articleID": @"NEWSID",
        @"date": @"POSTDATETIME",
        @"playerID": @"PLAYERID",
        @"firstName": @"FIRSTNAME",
        @"lastName": @"LASTNAME",
        @"position": @"MAJPOSIT",
        @"team": @"MAJTEAM",
        @"headline": @"HEADLINE",
        @"news": @"NEWS",
        @"analysis": @"ANALYSIS",
        @"sourceTitle": @"SOURCENAME",
        @"sourceLink": @"SOURCELINK",
        @"status": @"STATUSTEXT",
        @"injured": @"ISINJURED",
        @"active": @"ISACTIVE"
    }];
}

- (BOOL)isEqual:(RotoworldNews *)other {
    return self.articleID == other.articleID;
}

@end
