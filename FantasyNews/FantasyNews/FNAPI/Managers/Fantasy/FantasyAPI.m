//
//  FantasyAPI.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FantasyAPI.h"

@implementation FantasyAPI

+ (FantasyAPI *)sharedInstance {
    static FantasyAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FantasyAPI alloc] init];
    });
    return sharedInstance;
}

@end
