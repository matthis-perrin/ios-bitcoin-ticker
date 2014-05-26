//
//  Bitstamp.m
//  BitcoinTicker
//
//  Created by Ben on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#define channel_key   @"de504dc5763aeef9ff52"
#define reconnect_delay 3

#import "Bitstamp.h"
#import "Ticker.h"

@implementation Bitstamp
{
    NSString *lastBid;
    NSString *lastAsk;
}

- (void)runWithBlock:(void (^)(Ticker *))block
{
    _client = [PTPusher pusherWithKey:channel_key delegate:self encrypted:NO];
    _client.reconnectDelay = reconnect_delay;
    
    PTPusherChannel *channel = [_client subscribeToChannelNamed:@"order_book"];
    [channel bindToEventNamed:@"data" handleWithBlock:^(PTPusherEvent *channelEvent) {
        NSArray *bids = [channelEvent.data objectForKey:@"bids"];
        NSArray *asks = [channelEvent.data objectForKey:@"asks"];
        NSString *bid = [[bids objectAtIndex:0] objectAtIndex:0];
        NSString *ask = [[asks objectAtIndex:0] objectAtIndex:0];
        if (![lastBid isEqualToString:bid] || ![lastAsk isEqualToString:ask]) {
            block([[Ticker alloc] initWithDate:[NSDate date] withBid:bid withAsk:ask]);
        }
    }];
    [_client connect];
}

@end
