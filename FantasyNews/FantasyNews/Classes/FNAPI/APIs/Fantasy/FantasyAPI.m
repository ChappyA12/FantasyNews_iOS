//
//  FantasyAPI.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#define DISNEY_BASE_URL @"https://registerdisney.go.com/jgc/v5/client/ESPN-FANTASYLM-PROD/"
#define ESPN_LOGIN_BASE_URL @"http://fan.api.espn.com/apis/v2/"
#define ESPN_BASE_URL @"http://fantasy.espn.com/apis/v3/games/"
#define ERROR_DOMAIN @"com.chappyasel.fantasynews"

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
             completion:(void(^)(NSString *userID, NSError *error))completion {
    if (!apiKey) {
        NSLog(@"logInWithAPIKey passed nil for apiKey");
        completion(nil, [NSError errorWithDomain:ERROR_DOMAIN code:LoginErrorTypeNoAPIKey userInfo:nil]);
        return;
    }
    [self performRequest: [FNAPIRequest method:POST base:DISNEY_BASE_URL path:@"guest/login"
                                       headers:@{@"Authorization": [NSString stringWithFormat:@"APIKEY %@", apiKey]}
                                        params:nil body:@{@"loginValue": username, @"password": password}]
              completion:^(NSDictionary *response, NSDictionary *headers, NSError *error) {
                  if (error) {
                      if ([error.userInfo[@"response"] containsString:@"AUTHENTICATION_FAILED"]) {
                          NSLog(@"Bad login info: %@",error);
                          completion(nil, [NSError errorWithDomain:ERROR_DOMAIN code:LoginErrorTypeInvalidLogin userInfo:nil]);
                          return;
                      }
                      NSLog(@"%@",error);
                      completion(nil, [NSError errorWithDomain:ERROR_DOMAIN code:LoginErrorTypeOther userInfo:nil]);
                      return;
                  }
                  if (!response || ![response objectForKey:@"data"] || ![response[@"data"] objectForKey:@"token"] ||
                      ![response[@"data"][@"token"] objectForKey:@"swid"]) {
                      NSLog(@"Bad login data: no data.token.swid");
                      completion(nil, [NSError errorWithDomain:ERROR_DOMAIN code:LoginErrorTypeNoSWID userInfo:nil]);
                      return;
                  }
                  completion(response[@"data"][@"token"][@"swid"], nil);
              }];
}

- (void)userForUserID:(NSString *)userID
           completion:(void(^)(FantasyUser *user))completion {
    if (!userID) {
        NSLog(@"fantastUserForUserID passed nil for userID");
        completion(nil);
        return;
    }
    NSString *mod = [[userID stringByReplacingOccurrencesOfString:@"{" withString:@"%7B"]
                             stringByReplacingOccurrencesOfString:@"}" withString:@"%7D"];
    NSString *path = [NSString stringWithFormat:@"fans/%@", mod];
    [self performRequest: [FNAPIRequest method:GET base:ESPN_LOGIN_BASE_URL path:path
                                        params:@{@"context": @"fantasy"}]
              completion:^(NSDictionary *response, NSDictionary *headers, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  if (!response || ![response objectForKey:@"preferences"]) {
                      NSLog(@"Bad fantasy user data: no preferences");
                      completion(nil);
                      return;
                  }
                  NSError *JSONError;
                  FantasyUser *user = [[FantasyUser alloc] initWithDictionary:response error:&JSONError];
                  if (JSONError) {
                      NSLog(@"%@", JSONError);
                      completion(nil);
                      return;
                  }
                  completion(user);
              }];
}

- (void)scoringPeriodIDForSeasonID:(NSInteger)seasonID
                        completion:(void(^)(NSInteger scoringPeriodID))completion {
    NSString *path = [NSString stringWithFormat:@"fba/seasons/%ld", seasonID];
    [self performRequest: [FNAPIRequest method:GET base:ESPN_BASE_URL path:path
                                        params:@{@"view": @"kona_game_state"}]
              completion:^(NSDictionary *response, NSDictionary *headers, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(1);
                      return;
                  }
                  completion([response[@"currentScoringPeriod"][@"id"] integerValue]);
              }];
}

- (void)rosterForSeasonID:(NSInteger)seasonID
                 leagueID:(NSInteger)leagueID
                   teamID:(NSInteger)teamID
          scoringPeriodID:(NSInteger)scoringPeriodID
               completion:(void (^)(FantasyRoster *roster))completion {
    NSString *path = [NSString stringWithFormat:@"FBA/seasons/%ld/segments/0/leagues/%ld", seasonID, leagueID];
    [self performRequest: [FNAPIRequest method:GET base:ESPN_BASE_URL path:path
                                        params:@{@"forTeamId": [@(teamID) stringValue],
                                                 @"scoringPeriodId": [@(scoringPeriodID) stringValue],
                                                 @"view": @"cinco_wl_rosterInfo",
                                                 @"rand": @"0"}]
              completion:^(NSDictionary *response, NSDictionary *headers, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSError *JSONError;
                  FantasyRoster *roster = [[FantasyRoster alloc] initWithDictionary:response error:&JSONError];
                  if (JSONError) {
                      NSLog(@"%@", JSONError);
                      completion(nil);
                      return;
                  }
                  completion(roster);
              }];
}

- (void)playerMappingDictsForSeasonID:(NSInteger)seasonID
                           completion:(void(^)(NSDictionary *first, NSDictionary *last, NSDictionary *firstLast))completion {
    NSString *path = [NSString stringWithFormat:@"fba/seasons/%ld/players", seasonID];
    [self performRequest: [FNAPIRequest method:GET base:ESPN_BASE_URL path:path
                                        params:@{@"view": @"players_wl"}]
              completion:^(NSDictionary *response, NSDictionary *headers, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil, nil, nil);
                      return;
                  }
                  NSMutableDictionary *firstNames = @{}.mutableCopy;
                  NSMutableDictionary *lastNames = @{}.mutableCopy;
                  NSMutableDictionary *fullNames = @{}.mutableCopy;
                  for (NSDictionary *dict in response) {
                      NSNumber *espnID = dict[@"id"];
                      firstNames = [self dictionary:firstNames key:dict[@"firstName"] value:espnID];
                      lastNames = [self dictionary:lastNames key:dict[@"lastName"] value:espnID];
                      fullNames = [self dictionary:fullNames key:dict[@"fullName"] value:espnID];
                  }
                  completion(firstNames, lastNames, fullNames);
              }];
}

- (NSMutableDictionary *)dictionary:(NSMutableDictionary *)dict key:(NSString *)key value:(NSNumber *)value {
    if ([dict objectForKey:key]) {
        NSMutableArray *arr = dict[key];
        [arr addObject:value];
        dict[key] = arr;
    } else {
        dict[key] = @[value].mutableCopy;
    }
    return dict;
}

@end
