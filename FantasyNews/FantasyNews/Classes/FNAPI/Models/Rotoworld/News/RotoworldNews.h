//
//  RotoworldNews.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONModel.h"

@interface RotoworldNews : JSONModel

@property (nonatomic) NSInteger articleID;
@property (nonatomic) NSDate *date;

@property (nonatomic) NSInteger playerID;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *position;
@property (nonatomic) NSString *team;

@property (nonatomic) NSString *headline;
@property (nonatomic) NSString *news;
@property (nonatomic) NSString *analysis;

@property (nonatomic) NSString *sourceTitle;
@property (nonatomic) NSString *sourceLink;

@property (nonatomic) NSString *status;
@property (nonatomic) BOOL injured;
@property (nonatomic) BOOL active;

@end
