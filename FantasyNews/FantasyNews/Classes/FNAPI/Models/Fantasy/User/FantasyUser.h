//
//  FantasyUser.h
//  FantasyNews
//
//  Created by Chappy Asel on 12/1/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONModel.h"

@protocol FantasyGroup;
@class FantasyGroup;

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
@property (nonatomic) NSString *logoURL;

@property (nonatomic) NSString <Ignore> *leagueName;
@property (nonatomic) NSString <Ignore> *record;

@property (nonatomic) NSString *entryURL;
@property (nonatomic) NSString *scoreboardURL;

@property (nonatomic) NSArray <FantasyGroup *> <FantasyGroup> *groups;

@end



@interface FantasyGroup : JSONModel

@property (nonatomic) NSInteger groupID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger size;

@property (nonatomic) NSInteger wins;
@property (nonatomic) NSInteger losses;
@property (nonatomic) NSInteger ties;
@property (nonatomic) NSInteger points;
@property (nonatomic) NSInteger rank;

@end
