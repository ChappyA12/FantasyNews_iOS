//
//  ESPNLoginViewController.h
//  FantasyNews
//
//  Created by Chappy Asel on 12/1/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESPNLoginViewController, FantasyUser;

@protocol ESPNLoginViewControllerDelegate
- (void)espnLoginVC:(ESPNLoginViewController *)loginVC didSucceedWithResultFantasyUser:(FantasyUser *)user;
@end

@interface ESPNLoginViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic) id<ESPNLoginViewControllerDelegate> delegate;

@property (nonatomic) CGPoint originPoint;

@end
