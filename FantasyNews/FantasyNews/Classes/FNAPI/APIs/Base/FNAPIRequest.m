//
//  FNAPIRequest.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FNAPIRequest.h"

@implementation FNAPIRequest

+ (FNAPIRequest *)method:(NSString *)method
                    base:(NSString *)base
                    path:(NSString *)path {
    return [FNAPIRequest method:method base:base path:path headers:nil params:nil body:nil];
}

+ (FNAPIRequest *)method:(NSString *)method
                    base:(NSString *)base
                    path:(NSString *)path
                    body:(NSDictionary * _Nullable)body {
    return [FNAPIRequest method:method base:base path:path headers:nil params:nil body:body];
}

+ (FNAPIRequest *)method:(NSString *)method
                    base:(NSString *)base
                    path:(NSString *)path
                  params:(NSDictionary * _Nullable)params {
    return [FNAPIRequest method:method base:base path:path headers:nil params:params body:nil];
}

+ (FNAPIRequest *)method:(NSString *)method
                    base:(NSString *)base
                    path:(NSString *)path
                 headers:(NSDictionary * _Nullable)headers
                  params:(NSDictionary * _Nullable)params
                    body:(NSDictionary * _Nullable)body {
    FNAPIRequest *request = [[FNAPIRequest alloc] init];
    request.method = method;
    request.base = base;
    request.path = path;
    request.headers = headers;
    request.params = params;
    request.body = body;
    return request;
}

- (NSURL *)url {
    return [NSURL URLWithString:[self.base stringByAppendingString:self.path]];
}

@end
