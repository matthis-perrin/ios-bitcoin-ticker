//
//  Buttercoin.h
//  BitcoinTicker
//
//  Created by Ben on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SRWebSocket.h>
#import "Ticker.h"

@interface Buttercoin : NSObject <SRWebSocketDelegate>

- (void)runWithBlock:(void (^)(Ticker *))block;

@end
