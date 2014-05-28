//
//  ExchangeManager.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/26/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "ExchangeManager.h"
#import "Buttercoin.h"
#import "Bitstamp.h"
#import "Coinbase.h"

@implementation ExchangeManager

static NSMutableArray* exchanges;

+ (void) startExchange:(ExchangeType)type block:(void (^)(Ticker *))block {
    if (!exchanges) {
        exchanges = [[NSMutableArray alloc] init];
    }
    NSObject* exchange = NULL;
    
    switch (type) {
        case BUTTERCOIN: exchange = [[Buttercoin alloc] initWithBlock:block]; break;
        case BITSTAMP: exchange = [[Bitstamp alloc] initWithBlock:block]; break;
        case COINBASE: exchange = [[Coinbase alloc] initWithBlock:block]; break;
        default: break;
    }
    
    [exchanges addObject:exchange];
}

@end
