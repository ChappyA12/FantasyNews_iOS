//
//  TimeAgo.m
//  FantasyNews
//
//  Created by Chappy Asel on 7/5/16.
//  Copyright © 2016 CD. All rights reserved.
//

#import "TimeAgo.h"

@implementation TimeAgo

+ (NSString *)date:(NSDate *)date {
    NSDateComponents *components;
    if ([date compare:NSDate.date] == NSOrderedAscending)
         components = [NSCalendar.currentCalendar components:
            (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute)
                                                    fromDate:date
                                                      toDate:NSDate.date
                                                     options:0];
    else components = [NSCalendar.currentCalendar components:
            (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute)
                                                    fromDate:NSDate.date
                                                      toDate:date
                                                     options:0];
    if (components.year != 0)
        return [NSString stringWithFormat:@"%ldy",components.year];
    if (components.month != 0)
        return [NSString stringWithFormat:@"%ldmo",components.month];
    if (components.day != 0)
        return [NSString stringWithFormat:@"%ldd",components.day];
    if (components.hour != 0)
        return [NSString stringWithFormat:@"%ldh",components.hour];
    if (components.minute != 0)
        return [NSString stringWithFormat:@"%ldm",components.minute];
    else return @"now";
}

+ (NSString *)extendedDate:(NSDate *)date {
    NSDateComponents *components;
    if ([date compare:NSDate.date] == NSOrderedAscending)
        components = [NSCalendar.currentCalendar components:
                      (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute)
                                                   fromDate:date
                                                     toDate:NSDate.date
                                                    options:0];
    else components = [NSCalendar.currentCalendar components:
                       (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute)
                                                    fromDate:NSDate.date
                                                      toDate:date
                                                     options:0];
    if (components.year != 0)
        return @"over a year ago";
    if (components.month >= 3)
        return [NSString stringWithFormat:@"%ld months ago",components.month];
    if (components.day > 14)
        return [NSString stringWithFormat:@"%ld weeks ago",components.day / 7];
    if (components.day >= 7)
        return @"1 week ago";
    if (components.day == 1)
        return @"1 day ago";
    if (components.day != 0)
        return [NSString stringWithFormat:@"%ld days ago",components.day];
    if (components.hour == 1)
        return @"1 hour ago";
    if (components.hour != 0)
        return [NSString stringWithFormat:@"%ld hours ago",components.hour];
    if (components.minute == 1)
        return @"1 minute ago";
    if (components.minute != 0)
        return [NSString stringWithFormat:@"%ld minutes ago",components.minute];
    else return @"now";
}

@end
