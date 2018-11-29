//
//  FNAPI.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FNAPI.h"

@implementation FNAPI

+ (RotoworldAPI *)rotoworld {
    return RotoworldAPI.sharedInstance;
}

+ (FantasyAPI *)fantasy {
    return FantasyAPI.sharedInstance;
}

@end
