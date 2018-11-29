//
//  UIColor+FNColors.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIColor (FNColors)

typedef enum : NSUInteger {
    ColorSchemeDefault = 0,
    ColorSchemeDark = 1
} ColorScheme;

+ (void)changeColorSchemeTo:(ColorScheme)scheme;

+ (ColorScheme)colorScheme;

+ (void)reloadNavigationBarAppearance;

#pragma mark - UI colors

+ (UIColor *)FNBarColor;

+ (UIColor *)FNWhiteTextColor;

#pragma mark - system appearance

+ (UIStatusBarStyle)statusBarStyle;
+ (UIKeyboardAppearance)keyboardAppearance;

@end
