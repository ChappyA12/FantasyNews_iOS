//
//  RotoworldTeam.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONModel.h"

@class UIColor;

@interface RotoworldTeam : JSONModel

@property (nonatomic) NSString *teamID;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *name;
@property (nonatomic) UIColor *color;
@property (nonatomic) NSString *conference;
@property (nonatomic) NSDate *division;
@property (nonatomic) BOOL official;

@end
