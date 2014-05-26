//
//  Buttercoin.m
//  BitcoinTicker
//
//  Created by Ben on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "Buttercoin.h"

@implementation Buttercoin
{
    NSString *origin;
    NSString *url;
    NSMutableURLRequest *request;
    int frequency; // seconds
    int timeout; // seconds
    NSString *tickerMsg;
    
    NSString *lastBid;
    NSString *lastAsk;
    
    void (^userBlock)(Ticker *);
}

- (id)init
{
    if (self = [super init]) {
        origin = @"https://www.buttercoin.com";
        url = @"wss://api.buttercoin.com/api/v1/websocket";
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        [request setValue:origin forHTTPHeaderField:@"Origin"];
        
        frequency = 10;
        timeout = 30;
        tickerMsg = @"{\"query\":\"TICKER\",\"currencies\":[\"USD\",\"BTC\"]}";
    }
    return self;
}

- (void)runWithBlock:(void (^)(Ticker *))block
{
    userBlock = block;
    [self requestTicker];
}

- (void)requestTicker
{
    SRWebSocket *socket = [[SRWebSocket alloc] initWithURLRequest:request];
    socket.delegate = self;
    [socket open];
    [self performSelector:@selector(destroySocket:) withObject:socket afterDelay:timeout];
}

- (void)destroySocket:(SRWebSocket *)webSocket
{
    if (webSocket) {
        [webSocket close];
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    [webSocket send:tickerMsg];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    [self performSelector:@selector(requestTicker) withObject:nil afterDelay:frequency];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    [self performSelector:@selector(requestTicker) withObject:nil afterDelay:frequency];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if ([[json objectForKey:@"result"] isEqualToString:@"TICKER"]) {
        NSString *bid = [[json objectForKey:@"bid"] objectForKey:@"amount"];
        NSString *ask = [[json objectForKey:@"ask"] objectForKey:@"amount"];
        if (![lastBid isEqualToString:bid] || ![lastAsk isEqualToString:ask]) {
            lastBid = bid;
            lastAsk = ask;
            userBlock([[Ticker alloc] initWithDate:[NSDate date] withBid:bid withAsk:ask]);
        }
        [webSocket close];
    }
}

@end
