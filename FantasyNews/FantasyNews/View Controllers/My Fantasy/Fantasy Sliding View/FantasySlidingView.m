//
//  FantasySlidingView.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/2/18.
//  Copyright © 2018 CD. All rights reserved.
//

#import "FantasySlidingView.h"

@interface FantasySlidingView()
@property (nonatomic) UISelectionFeedbackGenerator *feedback;
@end

@implementation FantasySlidingView

+ (instancetype)loadFromNIB {
    FantasySlidingView *navBar = [[NSBundle mainBundle] loadNibNamed:@"FantasySlidingView" owner:self options:nil].firstObject;
    [navBar load];
    navBar.minHeight = 60;
    navBar.maxHeight = 400;
    navBar.feedback = [[UISelectionFeedbackGenerator alloc] init];
    return navBar;
}

- (void)setWidth:(float)width {
    [super setWidth:width];
}

@end
