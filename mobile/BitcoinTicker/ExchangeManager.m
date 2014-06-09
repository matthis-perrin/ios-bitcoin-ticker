//
//  ExchangeManager.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/26/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "ExchangeManager.h"

@implementation ExchangeManager {
    NSMutableURLRequest* request;
    SRWebSocket* socket;
}

static NSMutableDictionary* exchanges;
static void (^metaDataBlock)(NSDictionary*);


- (void) start {
    NSString* url = @"ws://198.23.133.167:4001";
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self startWebSocket];
}

- (void) startWebSocket {
    socket = [[SRWebSocket alloc] initWithURLRequest:request];
    socket.delegate = self;
    [socket open];
}


+ (void) registerForExchange:(NSString*)exchangeName block:(void (^)(Ticker*))block {
    if (!exchanges) {
        exchanges = [[NSMutableDictionary alloc] init];
    }
    [exchanges setValue:block forKey:exchangeName];
}

+ (void) registerForMetaData:(void (^)(NSDictionary*))block {
    metaDataBlock = block;
}


+ (void) broadcastTicker:(Ticker*)ticker forExchange:(NSString*)exchangeName {
    void (^userBlock)(Ticker*) = [exchanges valueForKey:exchangeName];
    if (userBlock != nil) {
        userBlock(ticker);
    }
}

+ (void) broadcastMetaData:(NSDictionary*)metaData {
    if (metaDataBlock != nil) {
        metaDataBlock(metaData);
    }
}


- (void) webSocketDidOpen:(SRWebSocket*)webSocket {
}

- (void) webSocket:(SRWebSocket*)webSocket didFailWithError:(NSError*)error {
    [self startWebSocket];
}

- (void) webSocket:(SRWebSocket*)webSocket didCloseWithCode:(NSInteger)code reason:(NSString*)reason wasClean:(BOOL)wasClean {
    [self startWebSocket];
}

- (void) webSocket:(SRWebSocket*)webSocket didReceiveMessage:(id)message
{
    NSData* data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSString* messageType = [json objectForKey:@"type"];
    NSDictionary* messageData = [json objectForKey:@"data"];
    
    if (messageType != nil) {
        if ([messageType isEqualToString:@"PRICE"]) {
            for (NSString* exchangeName in messageData) {
                NSDictionary* exchangeData = [messageData objectForKey:exchangeName];
                NSTimeInterval timestamp = [[exchangeData objectForKey:@"time"] doubleValue] / 1000.0;
                NSString* bid = [exchangeData objectForKey:@"bid"];
                NSString* ask = [exchangeData objectForKey:@"ask"];
                Ticker* ticker = [[Ticker alloc] initWithDate:[[NSDate alloc] initWithTimeIntervalSince1970:timestamp] withBid:bid withAsk:ask];
                [ExchangeManager broadcastTicker:ticker forExchange:exchangeName];
            }
        }
        else if ([messageType isEqualToString:@"METADATA"]) {
            [ExchangeManager broadcastMetaData:messageData];
        }
    }
}

@end
