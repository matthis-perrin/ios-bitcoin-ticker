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
    BITSTAMP
} ExchangeType;

@interface Exchange : NSObject

@property ExchangeType type;
@property NSString* name;
@property NSString* imageName;

- (id) initWithType:(ExchangeType)type name:(NSString*)_name image:(NSString*)_imageName;

@end
