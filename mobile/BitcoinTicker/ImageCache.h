//
//  ImageCache.h
//  BitcoinTicker
//
//  Created by Ben on 6/1/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject

+ (UIImage *)getImageWithUrl:(NSString *)imageURL;

@end
