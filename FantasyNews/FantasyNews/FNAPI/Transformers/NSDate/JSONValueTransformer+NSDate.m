//
//  JSONValueTransformer+NSDate.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONValueTransformer+NSDate.h"

@implementation JSONValueTransformer (NSDate)

- (NSDate *)NSDateFromNSString:(NSString *)string {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    return [formatter dateFromString:string];
}

- (NSString *)JSONObjectFromNSDate:(NSDate *)date {
    return nil;
}

@end
