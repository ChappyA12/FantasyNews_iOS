//
//  FantasyViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/1/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FantasyViewController.h"
#import "ZFModalTransitionAnimator.h"
#import "ESPNLoginViewController.h"

@interface FantasyViewController ()
@property (nonatomic) ZFModalTransitionAnimator *animator;
@end

@implementation FantasyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Fantasy";
}

- (IBAction)loginPressed:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ESPNLoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"espnlogin"];
    vc.originPoint = sender.center;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:vc];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    self.animator.bounces = NO;
    self.animator.dragable = NO;
    self.animator.behindViewScale = 1.0;
    self.animator.behindViewAlpha = 1.0;
    self.animator.transitionDuration = 0;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    vc.transitioningDelegate = self.animator;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
