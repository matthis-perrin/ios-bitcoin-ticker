//
//  Exchange.h
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exchange : NSObject

@property NSString* name;
@property NSString* imageUrl;
@property float topOffset;
@property float bottomOffset;

- (id) initWithName:(NSString*)_name image:(NSString*)_imageUrl;

@end
