//
//  JSONValueTransformer+UIColor.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONValueTransformer+UIColor.h"

@implementation JSONValueTransformer (UIColor)

- (UIColor *)UIColorFromNSString:(NSString *)string {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0
                           alpha:1.0];
}

- (NSString *)JSONObjectFromNSDate:(UIColor *)color {
    return nil;
}

@end
