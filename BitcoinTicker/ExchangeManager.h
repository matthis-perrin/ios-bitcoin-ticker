//
//  ExchangeManager.h
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/26/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticker.h"
#import "Exchange.h"

@interface ExchangeManager : NSObject

+ (void) startExchange:(ExchangeType)type block:(void (^)(Ticker *))block;

@end
