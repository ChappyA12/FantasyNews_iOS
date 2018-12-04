//
//  FantasyAPI.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNAPIBase.h"
#import "FantasyUser.h"
#import "FantasyRoster.h"

typedef enum LoginErrorType : NSUInteger {
    LoginErrorTypeInvalidLogin,
    LoginErrorTypeNoAPIKey,
    LoginErrorTypeNoSWID,
    LoginErrorTypeOther
} LoginErrorType;

@interface FantasyAPI : FNAPIBase

+ (FantasyAPI *)sharedInstance;

- (void)apiKey:(void(^)(NSString *apiKey))completion;

- (void)logInWithAPIKey:(NSString *)apiKey
               username:(NSString *)username
               password:(NSString *)password
             completion:(void(^)(NSString *userID, NSError *error))completion;

- (void)userForUserID:(NSString *)userID
           completion:(void(^)(FantasyUser *user))completion;

- (void)scoringPeriodIDForSeasonID:(NSInteger)seasonID
                        completion:(void(^)(NSInteger scoringPeriodID))completion;

- (void)rosterForSeasonID:(NSInteger)seasonID
                 leagueID:(NSInteger)leagueID
                   teamID:(NSInteger)teamID
          scoringPeriodID:(NSInteger)scoringPeriodID
               completion:(void(^)(FantasyRoster *roster))completion;

@end
