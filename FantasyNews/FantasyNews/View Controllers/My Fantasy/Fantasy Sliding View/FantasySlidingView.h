//
//  FantasySlidingView.h
//  FantasyNews
//
//  Created by Chappy Asel on 12/2/18.
//  Copyright © 2018 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlidingView.h"

@class FantasySlidingView;

@protocol FantasySlidingViewDelegate <NSObject>
@end

@interface FantasySlidingView : SlidingView

@property id<FantasySlidingViewDelegate> delegate;

+ (instancetype)loadFromNIB;

@end
