//
//  FantasyRoster.h
//  FantasyNews
//
//  Created by Chappy Asel on 12/4/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONModel.h"

@protocol FantasyPlayer;
@class FantasyPlayer;

@interface FantasyRoster : JSONModel

@property (nonatomic) NSInteger teamID;
@property (nonatomic) NSInteger leagueID;
@property (nonatomic) NSInteger seasonID;
@property (nonatomic) NSInteger gameID;
@property (nonatomic) NSInteger scoringPeriodID;

@property (nonatomic) NSArray <FantasyPlayer *> <FantasyPlayer> *players;

@end



@interface FantasyPlayer : JSONModel

@property (nonatomic) NSInteger rotoworldID;
@property (nonatomic) NSInteger espnID;

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;

@end
