//
//  Exchange.h
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BUTTERCOIN,
    BITSTAMP,
    COINBASE
} ExchangeType;

@interface Exchange : NSObject

@property ExchangeType type;
@property NSString* name;
@property NSString* imageName;
@property float topOffset;
@property float bottomOffset;

- (id) initWithType:(ExchangeType)_type name:(NSString*)_name image:(NSString*)_imageName;

@end
