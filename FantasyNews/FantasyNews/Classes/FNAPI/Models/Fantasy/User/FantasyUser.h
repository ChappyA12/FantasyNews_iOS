//
//  FantasyUser.h
//  FantasyNews
//
//  Created by Chappy Asel on 12/1/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONModel.h"

@protocol FantasyTeam;
@class FantasyTeam;

@interface FantasyUser : JSONModel

@property (nonatomic) NSString *userID;
@property (nonatomic) NSArray <FantasyTeam *> <FantasyTeam> *teams;

@end



@interface FantasyTeam : JSONModel

@property (nonatomic) NSString *teamFullID;
@property (nonatomic) NSString *type;

@property (nonatomic) NSInteger teamID;
@property (nonatomic) NSInteger leagueID;
@property (nonatomic) NSInteger seasonID;

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *abbrev;

@property (nonatomic) NSString *logoType;
@property (nonatomic) NSString *logoLink;

@property (nonatomic) NSString *entryLink;
@property (nonatomic) NSString *scoreboardLink;

@property (nonatomic) NSString *leagueName;
@property (nonatomic) NSInteger leagueSize;

@property (nonatomic) NSInteger wins;
@property (nonatomic) NSInteger losses;
@property (nonatomic) NSInteger ties;
@property (nonatomic) NSInteger points;
@property (nonatomic) NSInteger rank;

@end
