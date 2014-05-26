//
//  Coinbase.h
//  BitcoinTicker
//
//  Created by Ben on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticker.h"

@interface Coinbase : NSObject

- (void)runWithBlock:(void (^)(Ticker *))block;

@end
