//
//  SlidingView.h
//  Homework
//
//  Created by Chappy Asel on 8/29/16.
//  Copyright © 2016 CD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidingView : UIView

@property (strong, nonatomic) IBOutlet UIView *topContainerView;
@property (strong, nonatomic) IBOutlet UIView *bottomContainerView;

@property (nonatomic) BOOL collapsed;
@property (nonatomic) BOOL ignorePan;
@property (nonatomic) CGFloat minHeight;
@property (nonatomic) CGFloat maxHeight;

- (void)load;

- (void)collapse:(BOOL)collapse animated:(BOOL)animated;

- (void)setWidth:(float)width;

- (void)setYPos:(float)yPos;

- (void)updateNavBarTransparencies;

@end
