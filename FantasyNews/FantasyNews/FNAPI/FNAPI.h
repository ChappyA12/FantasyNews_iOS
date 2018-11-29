//
//  FNAPI.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RotoworldAPI.h"
#import "FantasyAPI.h"

@interface FNAPI : NSObject

+ (RotoworldAPI *)rotoworld;

+ (FantasyAPI *)fantasy;

@end
