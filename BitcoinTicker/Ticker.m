//
//  Ticker.m
//  BitcoinTicker
//
//  Created by Ben on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "Ticker.h"

@implementation Ticker

- (id)initWithDate:(NSDate *)date withBid:(NSString *)bid withAsk:(NSString *)ask
{
    if (self = [super init]) {
        self.date = date;
        self.bid = bid;
        self.ask = ask;
    }
    return self;
}

@end
