//
//  FNAPIRequest.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GET @"GET"
#define POST @"POST"

@interface FNAPIRequest : NSObject

@property (nonatomic) NSString *method;
@property (nonatomic) NSString *base;
@property (nonatomic) NSString *path;
@property (nonatomic) NSDictionary *headers;
@property (nonatomic) NSDictionary *params;
@property (nonatomic) NSDictionary *body;

+ (FNAPIRequest *)method:(NSString *)method
                    base:(NSString *)base
                    path:(NSString *)path;

+ (FNAPIRequest *)method:(NSString *)method
                    base:(NSString *)base
                    path:(NSString *)path
                    body:(NSDictionary * _Nullable)body;

+ (FNAPIRequest *)method:(NSString *)method
                    base:(NSString *)base
                    path:(NSString *)path
                  params:(NSDictionary * _Nullable)params;

+ (FNAPIRequest *)method:(NSString *)method
                    base:(NSString *)base
                    path:(NSString *)path
                 headers:(NSDictionary * _Nullable)headers
                  params:(NSDictionary * _Nullable)params
                    body:(NSDictionary * _Nullable)body;

- (NSURL *)url;

@end
