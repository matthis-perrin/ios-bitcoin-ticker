//
//  Ticker.h
//  BitcoinTicker
//
//  Created by Ben on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticker : NSObject

@property NSDate *date;
@property NSString *bid;
@property NSString *ask;

- (id)initWithDate:(NSDate *)date withBid:(NSString *)bid withAsk:(NSString *)ask;

@end
