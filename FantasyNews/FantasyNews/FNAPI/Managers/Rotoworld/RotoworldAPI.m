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

- (void)newsWithStartingArticleID:(NSInteger)articleID
                       completion:(void (^)(NSArray<NSObject *> *))completion {
    NSString *path = [self withToken: [NSString stringWithFormat:@"GetNews?sport=NBA&articleid=%ld", articleID]];
    [self performRequest: [FNAPIRequest method:GET base:BASE_URL path:path]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSLog(@"%@", response);
                  //completion(response[@"username"]);
              }];
}

#pragma mark - private helper methods

- (NSString *)withToken:(NSString *)string {
    return [NSString stringWithFormat:@"%@&token=%@", string, ROTO_TOKEN];
}

@end
