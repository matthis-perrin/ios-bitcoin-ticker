//
//  Exchange.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "Exchange.h"

@implementation Exchange

@synthesize type;
@synthesize name;
@synthesize imageName;


- (id) init {
    return [self initWithType:BUTTERCOIN name:@"" image:@""];
}

- (id) initWithType:(ExchangeType)_type name:(NSString*)_name image:(NSString*)_imageName {
    self = [super init];
    if (self) {
        type = _type;
        name = _name;
        imageName = _imageName;
    }
    return self;
}

@end
