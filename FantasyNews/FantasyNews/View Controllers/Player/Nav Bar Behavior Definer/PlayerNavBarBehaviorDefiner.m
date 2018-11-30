//
//  PlayerNavBarBehaviorDefiner.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/29/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "PlayerNavBarBehaviorDefiner.h"

#import "BLKFlexibleHeightBar.h"

@implementation PlayerNavBarBehaviorDefiner

# pragma mark - UIScrollViewDelegate methods

- (instancetype)init {
    if (self = [super init]) {
        [self addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.5];
        [self addSnappingPositionProgress:1.0 forProgressRangeStart:0.5 end:1.0];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isCurrentlySnapping) {
        NSInteger statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat progress = (scrollView.contentOffset.y + scrollView.contentInset.top + statusBarHeight)
                         / (self.flexibleHeightBar.maximumBarHeight - self.flexibleHeightBar.minimumBarHeight);
        self.flexibleHeightBar.progress = progress;
        [self.flexibleHeightBar setNeedsLayout];
    }
}

@end
