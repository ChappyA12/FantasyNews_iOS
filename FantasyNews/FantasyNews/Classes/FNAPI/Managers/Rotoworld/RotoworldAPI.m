//
//  RotoworldAPI.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "RotoworldAPI.h"

#define BASE_URL @"http://www.rotoworld.com/services/mobile.asmx/"
#define ROTO_TOKEN @"m1rw-xor-434s-bbjt-1"

@implementation RotoworldAPI

+ (RotoworldAPI *)sharedInstance {
    static RotoworldAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RotoworldAPI alloc] init];
    });
    return sharedInstance;
}

- (void)players:(void(^)(NSArray<RotoworldPlayer *> *players))completion {
    NSString *path = [self withToken: @"GetPlayers?sport=NBA"];
    [self performRequest: [FNAPIRequest method:GET base:BASE_URL path:path]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSError *JSONError;
                  NSMutableArray <RotoworldPlayer *> *result = @[].mutableCopy;
                  for (NSDictionary *player in response)
                      [result addObject:[[RotoworldPlayer alloc] initWithDictionary:player error:&JSONError]];
                  if (JSONError) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  completion(result);
              }];
}

- (void)teams:(void(^)(NSArray<RotoworldTeam *> *teams))completion {
    NSString *path = [self withToken: @"GetTeamInfo?sport=NBA"];
    [self performRequest: [FNAPIRequest method:GET base:BASE_URL path:path]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSError *JSONError;
                  NSMutableArray <RotoworldTeam *> *result = @[].mutableCopy;
                  for (NSDictionary *team in response)
                      [result addObject:[[RotoworldTeam alloc] initWithDictionary:team error:&JSONError]];
                  if (JSONError) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  completion(result);
              }];
}

- (void)newsWithStartingArticleID:(NSInteger)articleID
                       completion:(void (^)(NSArray<RotoworldNews *> *))completion {
    NSString *path = [self withToken: [NSString stringWithFormat:@"GetNews?articleid=%ld&sport=NBA", articleID]];
    [self performRequest: [FNAPIRequest method:GET base:BASE_URL path:path]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSError *JSONError;
                  NSMutableArray <RotoworldNews *> *result = @[].mutableCopy;
                  for (NSDictionary *news in response)
                      [result addObject:[[RotoworldNews alloc] initWithDictionary:news error:&JSONError]];
                  if (JSONError) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  completion(result);
              }];
}

- (void)newsForPlayerID:(NSInteger)playerID
             completion:(void(^)(NSArray<RotoworldNews *> *articles))completion {
    NSString *path = [self withToken: [NSString stringWithFormat:@"GetPlayersNews?playerid=%ld&sport=NBA", playerID]];
    [self performRequest: [FNAPIRequest method:GET base:BASE_URL path:path]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSError *JSONError;
                  NSMutableArray <RotoworldNews *> *result = @[].mutableCopy;
                  for (NSDictionary *news in response)
                      [result addObject:[[RotoworldNews alloc] initWithDictionary:news error:&JSONError]];
                  if (JSONError) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  completion(result);
              }];
}

- (void)newsHeadlines:(void(^)(NSArray<RotoworldNews *> *articles))completion {
    NSString *path = [self withToken: @"GetHeadlines?sport=NBA"];
    [self performRequest: [FNAPIRequest method:GET base:BASE_URL path:path]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSError *JSONError;
                  NSMutableArray <RotoworldNews *> *result = @[].mutableCopy;
                  for (NSDictionary *news in response)
                      [result addObject:[[RotoworldNews alloc] initWithDictionary:news error:&JSONError]];
                  if (JSONError) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  completion(result);
              }];
}

- (void)imageBaseURLs:(void(^)(NSString *teamURL, NSString *playerURL))completion {
    NSString *path = [self withToken: @"GetImageUrls?"];
    [self performRequest: [FNAPIRequest method:GET base:BASE_URL path:path]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil, nil);
                      return;
                  }
                  for (NSDictionary *urls in response) {
                      if ([urls[@"Sport"] isEqualToString:@"NBA"]) {
                          completion(urls[@"TeamURL"], urls[@"PlayerURL"]);
                          return;
                      }
                  }
                  completion(nil, nil);
              }];
}

#pragma mark - private helper methods

- (NSString *)withToken:(NSString *)string {
    if (![string containsString:@"="]) return [NSString stringWithFormat:@"%@token=%@", string, ROTO_TOKEN];
    return [NSString stringWithFormat:@"%@&token=%@", string, ROTO_TOKEN];
}

@end
