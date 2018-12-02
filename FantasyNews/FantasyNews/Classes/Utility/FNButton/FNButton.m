//
//  FNButton.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/2/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FNButton.h"

@implementation FNButton

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if (!enabled) {
        [UIView animateWithDuration:0.08 animations:^{
            self.transform = CGAffineTransformMakeScale(0.92, 0.92);
            self.alpha = 0.5;
        }];
    }
    else {
        [UIView animateWithDuration:0.08 animations:^{
            self.transform = CGAffineTransformIdentity;
            self.alpha = 1.0;
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:0.08 animations:^{
        self.transform = CGAffineTransformMakeScale(0.92, 0.92);
        self.alpha = 0.9;
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:0.08 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:0.08 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    }];
}

@end
