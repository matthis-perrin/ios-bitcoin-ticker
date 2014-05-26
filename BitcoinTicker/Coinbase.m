//
//  Coinbase.m
//  BitcoinTicker
//
//  Created by Ben on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "Coinbase.h"

@implementation Coinbase
{
    NSString *url;
    NSURLRequest *request;
    int frequency; // seconds
    int timeout; // seconds
    
    NSString *lastBid;
    NSString *lastAsk;
}

- (id)init
{
    if (self = [super init]) {
        url = @"wss://api.buttercoin.com/api/v1/websocket";
        request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        
        frequency = 2;
        timeout = 5;
    }
    return self;
}

- (void)runWithBlock:(void (^)(Ticker *))block
{
    
}

@end
