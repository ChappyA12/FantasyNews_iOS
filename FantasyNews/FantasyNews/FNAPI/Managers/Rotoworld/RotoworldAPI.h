//
//  RotoworldAPI.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNAPIBase.h"

@interface RotoworldAPI : FNAPIBase

+ (RotoworldAPI *)sharedInstance;

- (void)newsWithStartingArticleID:(NSInteger)articleID
                       completion:(void(^)(NSArray<NSObject *> *articles))completion;

@end
