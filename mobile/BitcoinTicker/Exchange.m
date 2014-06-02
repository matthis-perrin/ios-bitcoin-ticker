//
//  Exchange.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "Exchange.h"

@implementation Exchange

@synthesize name;
@synthesize imageUrl;


- (id) init {
    return [self initWithName:@"" image:@""];
}

- (id) initWithName:(NSString*)_name image:(NSString*)_imageUrl {
    self = [super init];
    if (self) {
        name = _name;
        imageUrl = _imageUrl;
    }
    return self;
}

@end
