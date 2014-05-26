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
    NSURLRequest *buyRequest;
    NSURLRequest *sellRequest;
    int frequency; // seconds
    
    NSString *lastBid;
    NSString *lastAsk;
    
    void (^userBlock)(Ticker *);
}

- (id)init
{
    if (self = [super init]) {
        buyRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://coinbase.com/api/v1/prices/buy"]];
        sellRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://coinbase.com/api/v1/prices/sell"]];
        frequency = 2;
    }
    return self;
}

- (void)runWithBlock:(void (^)(Ticker *))block
{
    userBlock = block;
    [NSTimer scheduledTimerWithTimeInterval:frequency target:self selector:@selector(requestTicker) userInfo:nil repeats:YES];
}

- (void)requestTicker
{
    NSString *bid = [self httpRequest:sellRequest];
    NSString *ask = [self httpRequest:buyRequest];
    if (![lastBid isEqualToString:bid] || ![lastAsk isEqualToString:ask]) {
        lastBid = bid;
        lastAsk = ask;
        userBlock([[Ticker alloc] initWithDate:[NSDate date] withBid:bid withAsk:ask]);
    }
}

- (NSString *)httpRequest:(NSURLRequest *)request
{
    NSError* error = [[NSError alloc] init];
    NSHTTPURLResponse* responseCode = nil;
    
    NSData* oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if ([responseCode statusCode] != 200) {
        return nil;
    }
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:oResponseData options:0 error:nil];

    return [[json objectForKey:@"subtotal"] objectForKey:@"amount"];
}

@end
