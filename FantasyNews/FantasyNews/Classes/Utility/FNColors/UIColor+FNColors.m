//
//  UIColor+FNColors.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CD. All rights reserved.
//

#import "UIColor+FNColors.h"

@implementation UIColor (HWColors)

+ (void)changeColorSchemeTo:(ColorScheme)scheme {
    [[NSUserDefaults standardUserDefaults] setObject:@(scheme) forKey:@"colorScheme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"colorSchemeChange" object:self];
    [self reloadNavigationBarAppearance];
}

+ (ColorScheme)colorScheme {
    return (ColorScheme)[[NSUserDefaults standardUserDefaults] stringForKey:@"colorScheme"].intValue;
}

+ (void)reloadNavigationBarAppearance {
    UINavigationBar.appearance.barTintColor = UIColor.FNBarColor;
    UINavigationBar.appearance.tintColor = UIColor.FNWhiteTextColor;
    UINavigationBar.appearance.translucent = NO;
    UINavigationBar.appearance.titleTextAttributes = @{NSForegroundColorAttributeName:UIColor.FNWhiteTextColor,
                                                       NSFontAttributeName:[UIFont systemFontOfSize:21 weight:UIFontWeightSemibold]};
    UINavigationBar.appearance.prefersLargeTitles = YES;
    UINavigationBar.appearance.largeTitleTextAttributes = @{NSForegroundColorAttributeName:UIColor.FNWhiteTextColor,
                                                            NSFontAttributeName:[UIFont systemFontOfSize:32 weight:UIFontWeightBold]};
    UINavigationBar.appearance.shadowImage = [[UIImage alloc] init];
    UINavigationBar.appearance.barStyle = UIBarStyleBlack;
}

#pragma mark - UI colors

+ (UIColor *)FNBarColor {
    switch (self.colorScheme) {
        case ColorSchemeDefault: return [UIColor colorWithRed:231/255.0 green:131/255.0 blue:59/255.0 alpha:1];
        case ColorSchemeDark:    return [UIColor colorWithRed:231/255.0 green:131/255.0 blue:59/255.0 alpha:1];
        default: return                 [UIColor colorWithRed:231/255.0 green:131/255.0 blue:59/255.0 alpha:1];
    }
}

+ (UIColor *)FNWhiteTextColor {
    switch (self.colorScheme) {
        case ColorSchemeDefault: return [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        case ColorSchemeDark:    return [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        default: return                 [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    }
}

#pragma mark - system appearance

+ (UIStatusBarStyle)statusBarStyle {
    switch (self.colorScheme) {
        case ColorSchemeDefault: return UIStatusBarStyleDefault;
        case ColorSchemeDark:    return UIStatusBarStyleDefault;
        default: return UIStatusBarStyleDefault;
    }
}

+ (UIKeyboardAppearance)keyboardAppearance {
    switch (self.colorScheme) {
        case ColorSchemeDefault: return UIKeyboardAppearanceDark;
        case ColorSchemeDark:    return UIKeyboardAppearanceDark;
        default: return UIKeyboardAppearanceDark;
    }
}

@end
