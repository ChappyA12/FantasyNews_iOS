//
//  FNAPIBase.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FNAPIBase.h"

@implementation FNAPIBase

- (void)performRequest:(FNAPIRequest *)request
            completion:(void (^)(NSDictionary *response, NSError *error))completion {
    if (request.params) {
        request.path = [request.path stringByAppendingString:@"?"];
        for (NSString *key in request.params.allKeys) {
            NSString *value = request.params[key];
            request.path = [NSString stringWithFormat:@"%@%@=%@&",request.path,
                                key, [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
        }
        request.path = [request.path substringToIndex:request.path.length-1];
    }
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:request.url
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:10];
    requestObj.HTTPMethod = request.method;
    if (request.body) requestObj.HTTPBody = [NSJSONSerialization dataWithJSONObject:request.body
                                                                            options:0 error:nil];
    [self addMetadataToRequest:requestObj];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:requestObj
                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                       if (error) {
                           completion(nil, error);
                           return;
                       }
                       NSInteger statusCode = 200;
                       if ([response respondsToSelector:@selector(statusCode)])
                           statusCode = [(NSHTTPURLResponse *)response statusCode];
                       if (statusCode < 200 || statusCode > 299) {
                           NSString *err = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
                           completion(nil, [NSError errorWithDomain:NSURLErrorDomain code:statusCode userInfo:@{@"response": err}]);
                           return;
                       }
                       NSError *jsonError;
                       NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:0
                                                                                      error:&jsonError];
                       if (jsonError) {
                           NSLog(@"JSON Error Output:\n%@", [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding]);
                           completion(nil, error);
                           return;
                       }
                       completion(jsonResponse, nil);
                   }];
    [task resume];
}

#pragma mark - private helper methods

- (void)addMetadataToRequest:(NSMutableURLRequest *)request {
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

@end
