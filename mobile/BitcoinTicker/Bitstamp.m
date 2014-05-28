//
//  Bitstamp.m
//  BitcoinTicker
//
//  Created by Ben on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "Bitstamp.h"
#import "Ticker.h"

@implementation Bitstamp
{
    NSString *key;
    int reconnectDelay;
    
    NSString *lastBid;
    NSString *lastAsk;
}

- (id) initWithBlock:(void (^)(Ticker *))block;
{
    if (self = [super init]) {
        key = @"de504dc5763aeef9ff52";
        reconnectDelay = 3;
        
        [self runWithBlock:block];
    }
    return self;
}

- (void)runWithBlock:(void (^)(Ticker *))block
{
    _client = [PTPusher pusherWithKey:key delegate:self encrypted:NO];
    _client.reconnectDelay = reconnectDelay;
    
    PTPusherChannel *channel = [_client subscribeToChannelNamed:@"order_book"];
    [channel bindToEventNamed:@"data" handleWithBlock:^(PTPusherEvent *channelEvent) {
        NSArray *bids = [channelEvent.data objectForKey:@"bids"];
        NSArray *asks = [channelEvent.data objectForKey:@"asks"];
        NSString *bid = [[bids objectAtIndex:0] objectAtIndex:0];
        NSString *ask = [[asks objectAtIndex:0] objectAtIndex:0];
        if (![lastBid isEqualToString:bid] || ![lastAsk isEqualToString:ask]) {
            lastBid = bid;
            lastAsk = ask;
            block([[Ticker alloc] initWithDate:[NSDate date] withBid:bid withAsk:ask]);
        }
    }];
    [_client connect];
}

@end
