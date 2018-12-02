//
//  ESPNLoginViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/1/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "ESPNLoginViewController.h"
#import "FNAPI.h"

@interface ESPNLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic) BOOL needsAnimation;
@property (nonatomic) BOOL firstLoad;

@end

@implementation ESPNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needsAnimation = YES;
    self.firstLoad = YES;
    self.scrollView.delegate = self;
}

- (void)viewDidLayoutSubviews {
    if (self.firstLoad) {
        self.contentView.alpha = 0.0;
        self.backgroundView.alpha = 0.0;
        self.firstLoad = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self animateIn];
    self.needsAnimation = YES;
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self animateOut];
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    [self animateOut];
}

- (void)login {
    [FNAPI.fantasy apiKey:^(NSString *apiKey) {
        [FNAPI.fantasy logInWithAPIKey:apiKey username:@"x" password:@"x" completion:^(NSString *userID) {
            [FNAPI.fantasy fantasyUserForUserID:userID completion:^(FantasyUser *user) {
                
            }];
        }];
    }];
}

#pragma mark - scrollView delegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    bool neglegable = fabs(velocity.y) < 0.2;
    float offset = fabs(scrollView.contentOffset.y);
    bool offsetPositive = scrollView.contentOffset.y >= 0;
    bool velocityPositive = velocity.y >= 0;
    if (neglegable && offset < 60.0) { } //no dismiss
    else if (!neglegable && (offsetPositive != velocityPositive)) { } //no dismiss
    else { //dismiss
        [self animateOut];
        [UIView animateWithDuration:.75 delay:.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (scrollView.contentOffset.y >= 0)
                scrollView.center = CGPointMake(scrollView.center.x, scrollView.center.y-scrollView.frame.size.height);
            else scrollView.center = CGPointMake(scrollView.center.x, scrollView.center.y+scrollView.frame.size.height);
        } completion:nil];
    }
}

#pragma mark - animation

- (void)animateIn {
    if (self.needsAnimation) {
        self.backgroundView.alpha = 0.0;
        self.contentView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.contentView.alpha = 0.5;
    }
    CGPoint endPoint = self.contentView.center;
    self.contentView.center = CGPointMake(-self.contentView.frame.origin.x+self.originPoint.x,
                                        -self.contentView.frame.origin.y+self.originPoint.y);
    [UIView animateWithDuration:(self.needsAnimation)? 0.25 : 0.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.center = endPoint;
        self.contentView.alpha = 0.994; //prevents shadow
        self.backgroundView.alpha = 1.0;
    } completion:nil];
}

- (void)animateOut {
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundView.alpha = 0.0;
        self.contentView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end
