//
//  ExchangeManager.h
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/26/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SRWebSocket.h>
#import "Ticker.h"
#import "Exchange.h"

@interface ExchangeManager : NSObject <SRWebSocketDelegate>

- (void) start;

+ (void) registerForExchange:(NSString*)exchangeName block:(void (^)(Ticker*))block;
+ (void) broadcastTicker:(Ticker*)ticker forExchange:(NSString*)exchangeName;
+ (void) registerForMetaData:(void (^)(NSDictionary*))block;

@end
