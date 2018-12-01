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

@interface FantasyAPI : FNAPIBase

+ (FantasyAPI *)sharedInstance;

- (void)apiKey:(void(^)(NSString *apiKey))completion;

- (void)logInWithAPIKey:(NSString *)apiKey
               username:(NSString *)username
               password:(NSString *)password
             completion:(void(^)(NSString *userID))completion;

- (void)fantasyUserForUserID:(NSString *)userID
                  completion:(void(^)(FantasyUser *user))completion;

@end
