//
//  DateUtils.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/26/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (NSString*) timeFromNow:(NSDate*)date {
    int seconds = -[date timeIntervalSinceNow];

    if (seconds < 1) { return @"Just now"; }
    if (seconds < 60) { return [self formatValue:seconds withUnit:@"s"]; }

    int minutes = seconds / 60;
    if (minutes < 60) { return [self formatValue:minutes withUnit:@"m"]; }

    int hours = minutes / 60;
    return [self formatValue:hours withUnit:@"h"];
}

+ (NSString*) formatValue:(int)value withUnit:(NSString*)unit {
    return [NSString stringWithFormat:@"%d%@", value, unit];
}


@end
