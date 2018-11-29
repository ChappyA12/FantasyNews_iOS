//
//  FNAPIBase.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNAPIRequest.h"

@interface FNAPIBase : NSObject

- (void)performRequest:(FNAPIRequest *)request
            completion:(void (^)(NSDictionary *response, NSError *error))completion;

@end
