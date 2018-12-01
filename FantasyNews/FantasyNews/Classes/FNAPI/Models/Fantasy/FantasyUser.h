//
//  FantasyUser.h
//  FantasyNews
//
//  Created by Chappy Asel on 12/1/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONModel.h"

@protocol FantasyGroup;

@interface FantasyGroup : JSONModel

@property (nonatomic) NSInteger groupID;
@property (nonatomic) NSString *name;

@end



@protocol FantasyTeam;

@interface FantasyTeam : JSONModel

@property (nonatomic) NSString *teamFullID;
@property (nonatomic) NSString *type;

@property (nonatomic) NSInteger teamID;
@property (nonatomic) NSInteger groupID;
@property (nonatomic) NSInteger seasonID;

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *abbrev;
@property (nonatomic) NSString <Ignore> *groupName;

@property (nonatomic) NSString *logoType;
@property (nonatomic) NSString *logoURL;

@property (nonatomic) NSArray <FantasyGroup *> <FantasyGroup> *groups;

@end



@interface FantasyUser : JSONModel

@property (nonatomic) NSString *userID;
@property (nonatomic) NSArray <FantasyTeam *> <FantasyTeam> *teams;

@end
