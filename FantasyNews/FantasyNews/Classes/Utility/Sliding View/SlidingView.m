//
//  SlidingView.m
//  Homework
//
//  Created by Chappy Asel on 8/29/16.
//  Copyright © 2016 CD. All rights reserved.
//

#import "SlidingView.h"

@interface SlidingView()
@property (strong, nonatomic) IBOutlet UIImageView *dragIncicatorView;
@property (nonatomic) CGPoint offset;
@property (nonatomic) BOOL isPanning;
@end

@implementation SlidingView

- (void)load {
    self.dragIncicatorView.image = [self.dragIncicatorView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.dragIncicatorView.tintColor = UIColor.whiteColor;
    self.backgroundColor = UIColor.FNBarColor;
    self.collapsed = NO;
    self.ignorePan = NO;
    self.layer.cornerRadius = 16;
    self.clipsToBounds = true;
    self.minHeight = 80;
    self.maxHeight = 400;
}

- (void)setMinHeight:(CGFloat)minHeight {
    BOOL hasBottomBar = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom > 10.0;
    _minHeight = minHeight + ((hasBottomBar) ? 20 : 0);
}

- (void)setMaxHeight:(CGFloat)maxHeight {
    BOOL hasBottomBar = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom > 10.0;
    _maxHeight = maxHeight + ((hasBottomBar) ? 20 : 0);
}

- (void)collapse:(BOOL)collapse animated:(BOOL)animated {
    if (self.isPanning) return;
    _collapsed = collapse;
    if (animated) {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(0, (collapse) ? self.superview.frame.size.height :
                                                    self.superview.frame.size.height - self.minHeight,
                                    self.frame.size.width, self.frame.size.height);
        }];
    }
    else {
        self.frame = CGRectMake(0, (collapse) ? self.superview.frame.size.height :
                                                self.superview.frame.size.height - self.minHeight,
                                self.frame.size.width, self.frame.size.height);
    }
}

- (void)setWidth:(float)width {
    self.frame = CGRectMake(0, self.frame.origin.y, width, 2000);
}

- (void)setYPos:(float)yPos {
    float offset = self.superview.frame.size.height-yPos;
    if (offset > self.maxHeight) offset = self.maxHeight + sqrt(offset-self.maxHeight)+(offset-self.maxHeight)/8;
    self.frame = CGRectMake(0, self.superview.frame.size.height-offset, self.frame.size.width, self.frame.size.height);
    [self updateNavBarTransparencies];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.offset = [sender locationInView:self];
        self.isPanning = YES;
    }
    float currentOffset = self.superview.frame.size.height-[sender locationInView:self.superview].y;
    [UIView animateWithDuration:0.01 animations:^{
        [self setYPos:self.superview.frame.size.height-currentOffset-self.offset.y];
    }];
    if(sender.state == UIGestureRecognizerStateEnded) {
        float velocity = [sender velocityInView:self.superview].y;
        [self animateNavBarToBaselineWithVelocity:velocity];
        self.isPanning = NO;
    }
}

- (void)animateNavBarToBaselineWithVelocity:(float)velocity {
    float currentOffset = self.superview.frame.size.height-self.frame.origin.y;
    bool animateToBottom = NO;
    if (currentOffset > self.maxHeight+1) animateToBottom = NO;
    else if (currentOffset < self.minHeight-1) animateToBottom = YES;
    else if (velocity > 0) animateToBottom = YES;
    [self startUpdateTimer];
    if (animateToBottom) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:10.0 initialSpringVelocity:0
                            options:UIViewAnimationOptionTransitionNone animations:^{
                                [self setYPos:self.superview.frame.size.height-self.minHeight];
                            } completion:^(BOOL finished) {
                                [self endUpdateTimer];
                            }];
    }
    else {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:10.0 initialSpringVelocity:0
                            options:UIViewAnimationOptionTransitionNone animations:^{
                                [self setYPos:self.superview.frame.size.height-self.maxHeight];
                            } completion:^(BOOL finished) {
                                [self endUpdateTimer];
                            }];
    }
}

NSTimer *updateTimer;

- (void)startUpdateTimer {
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                   target:self
                                                 selector:@selector(updateNavBarTransparencies)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)endUpdateTimer {
    [updateTimer invalidate];
}

- (void)updateNavBarTransparencies {
    float currentOffset = self.superview.frame.size.height-self.frame.origin.y;
    if (self.ignorePan) {
        self.bottomContainerView.alpha = 1.0;
        self.topContainerView.alpha = 0.0;
    }
    else if (currentOffset-self.minHeight < 20) { //all days (first 20)
        self.topContainerView.alpha = 1.0;
        self.bottomContainerView.alpha = 0.0;
    }
    else if (currentOffset < self.maxHeight-20) { //transition
        float maxNet = self.maxHeight-self.minHeight-40;
        float netDist = currentOffset-self.minHeight-20;
        self.topContainerView.alpha = 1 - netDist / maxNet;
        self.bottomContainerView.alpha = netDist / maxNet;
    }
    else { //all calendar (last 20)
        self.topContainerView.alpha = 0.0;
        self.bottomContainerView.alpha = 1.0;
    }
}

- (void)setIgnorePan:(BOOL)ignore {
    _ignorePan = ignore;
    [self updateNavBarTransparencies];
}

@end

