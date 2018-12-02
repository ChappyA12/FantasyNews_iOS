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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (nonatomic) BOOL needsAnimation;
@property (nonatomic) BOOL firstLoad;

@property (nonatomic) NSString *apiKey;

@end

@implementation ESPNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needsAnimation = YES;
    self.firstLoad = YES;
    self.scrollView.delegate = self;
    self.errorLabel.hidden = true;
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    self.loginButton.enabled = false;
}

- (void)viewDidLayoutSubviews {
    if (self.firstLoad) {
        self.contentView.alpha = 0.0;
        self.backgroundView.alpha = 0.0;
        self.firstLoad = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [FNAPI.fantasy apiKey:^(NSString *apiKey) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.apiKey = apiKey;
        });
    }];
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
    [self logIn];
}

- (void)logIn {
    self.errorLabel.hidden = true;
    if (!self.apiKey) {
        self.errorLabel.text = @"Trouble connecting with ESPN. Please try again later.";
        self.errorLabel.hidden = false;
        return;
    }
    [self.loadingIndicator startAnimating];
    self.loginButton.enabled = false;
    [FNAPI.fantasy logInWithAPIKey:self.apiKey
                          username:self.usernameField.text
                          password:self.passwordField.text
                        completion:^(NSString *userID, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [self.loadingIndicator stopAnimating];
                self.loginButton.enabled = true;
                switch (error.code) {
                    case LoginErrorTypeInvalidLogin:
                        self.errorLabel.text = @"Your username or password is incorrect. Please try again.";
                        break;
                    case LoginErrorTypeNoAPIKey:
                        self.errorLabel.text = @"Trouble connecting with ESPN. Please try again later.";
                        break;
                    case LoginErrorTypeNoSWID:
                        self.errorLabel.text = @"We could not process your account. Please try again later.";
                        break;
                    default:
                        self.errorLabel.text = @"Something went wrong. Please try again later.";
                        break;
                }
                self.errorLabel.hidden = false;
                return;
            }
        });
        [FNAPI.fantasy fantasyUserForUserID:userID
                                 completion:^(FantasyUser *user) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.loadingIndicator stopAnimating];
                 self.loginButton.enabled = true;
                 if (!user) {
                     self.errorLabel.text = @"We could not process your account. Please try again later.";
                     self.errorLabel.hidden = false;
                     return;
                 }
                 [self animateOut];
             });
         }];
     }];
}

#pragma mark - textField handling

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameField) {
        [textField resignFirstResponder];
        [self.passwordField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
        [self logIn];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ((self.usernameField.text.length > 0 && textField == self.passwordField && new.length > 0) ||
        (self.passwordField.text.length > 0 && textField == self.usernameField && new.length > 0))
         self.loginButton.enabled = true;
    else self.loginButton.enabled = false;
    return true;
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
