//
//  Bitstamp.h
//  BitcoinTicker
//
//  Created by Ben on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Pusher.h>
#import "Ticker.h"

@interface Bitstamp : NSObject <PTPusherDelegate>

@property (nonatomic, retain) PTPusher *client;

- (id) initWithBlock:(void (^)(Ticker *))block;

@end
