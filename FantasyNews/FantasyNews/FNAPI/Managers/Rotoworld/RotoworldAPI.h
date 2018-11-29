//
//  RotoworldAPI.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNAPIBase.h"
#import "RotoworldPlayer.h"
#import "RotoworldTeam.h"
#import "RotoworldNews.h"

@interface RotoworldAPI : FNAPIBase

+ (RotoworldAPI *)sharedInstance;

- (void)players:(void(^)(NSArray<RotoworldPlayer *> *players))completion;

- (void)teams:(void(^)(NSArray<RotoworldTeam *> *teams))completion;

- (void)newsWithStartingArticleID:(NSInteger)articleID
                       completion:(void(^)(NSArray<RotoworldNews *> *articles))completion;

- (void)newsForPlayerID:(NSInteger)playerID
             completion:(void(^)(NSArray<RotoworldNews *> *articles))completion;

- (void)newsHeadlines:(void(^)(NSArray<RotoworldNews *> *articles))completion;

- (void)imageBaseURLs:(void(^)(NSString *teamURL, NSString *playerURL))completion;

@end
