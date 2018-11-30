//
//  FantasyAPI.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#define DISNEY_BASE_URL @"https://registerdisney.go.com/jgc/v5/client/ESPN-FANTASYLM-PROD/"
#define ESPN_BASE_URL @"http://fan.api.espn.com/apis/v2/"

#import "FantasyAPI.h"

@implementation FantasyAPI

+ (FantasyAPI *)sharedInstance {
    static FantasyAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FantasyAPI alloc] init];
    });
    return sharedInstance;
}

- (void)apiKey:(void(^)(NSString *apiKey))completion {
    [self performRequest: [FNAPIRequest method:POST base:DISNEY_BASE_URL path:@"api-key"]
              completion:^(NSDictionary *response, NSDictionary *headers, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  if (!headers || ![headers objectForKey:@"api-key"]) {
                      NSLog(@"Disney api key fetch error: header.api-key not found");
                      completion(nil);
                  }
                  completion(headers[@"api-key"]);
              }];
}

- (void)logInWithAPIKey:(NSString *)apiKey
               username:(NSString *)username
               password:(NSString *)password
             completion:(void(^)(NSString *userID))completion {
    [self performRequest: [FNAPIRequest method:POST base:DISNEY_BASE_URL path:@"guest/login"
                                       headers:@{@"Authorization": [NSString stringWithFormat:@"APIKEY %@", apiKey]}
                                        params:nil body:@{@"loginValue": username, @"password": password}]
              completion:^(NSDictionary *response, NSDictionary *headers, NSError *error) {
                  if (error) {
                      if ([error.userInfo[@"response"] containsString:@"AUTHENTICATION_FAILED"]) {
                          NSLog(@"Bad login info: %@",error);
                          completion(nil);
                          return;
                      }
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  if (!response || ![response objectForKey:@"data"] || ![response[@"data"] objectForKey:@"token"] ||
                      ![response[@"data"][@"token"] objectForKey:@"swid"]) {
                      NSLog(@"Bad login data: no data.token.swid");
                      completion(nil);
                      return;
                  }
                  completion(response[@"data"][@"token"][@"swid"]);
              }];
}

- (void)fantasyInfoForUserID:(NSString *)userID
                  completion:(void(^)(NSObject *fantasyInfo))completion {
    NSString *mod = [[userID stringByReplacingOccurrencesOfString:@"{" withString:@"%7B"]
                             stringByReplacingOccurrencesOfString:@"}" withString:@"%7D"];
    NSString *path = [NSString stringWithFormat:@"fans/%@", mod];
    [self performRequest: [FNAPIRequest method:GET base:ESPN_BASE_URL path:path
                                        params:@{@"context": @"fantasy"}]
              completion:^(NSDictionary *response, NSDictionary *headers, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  completion(response);
              }];
}

@end
