//
//  RotoworldPlayer.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONModel.h"

@interface RotoworldPlayer : JSONModel

@property (nonatomic) NSInteger playerID;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *position;
@property (nonatomic) NSString *team;
@property (nonatomic) NSDate *birthday;

@end
