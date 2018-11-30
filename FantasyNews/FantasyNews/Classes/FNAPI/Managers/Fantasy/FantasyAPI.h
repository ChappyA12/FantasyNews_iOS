//
//  FantasyAPI.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNAPIBase.h"

@interface FantasyAPI : FNAPIBase

+ (FantasyAPI *)sharedInstance;

- (void)apiKey:(void(^)(NSString *apiKey))completion;

- (void)logInWithAPIKey:(NSString *)apiKey
               username:(NSString *)username
               password:(NSString *)password
             completion:(void(^)(NSString *userID))completion;

- (void)fantasyInfoForUserID:(NSString *)userID
                  completion:(void(^)(NSObject *fantasyInfo))completion;

@end
