//
//  ImageCache.m
//  BitcoinTicker
//
//  Created by Ben on 6/1/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "ImageCache.h"

@implementation ImageCache

+ (UIImage *)getImageWithUrl:(NSString *)imageURL
{
    NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = [self hash:imageURL];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
    
    NSData* imageData;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // From the internet
        imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
        [imageData writeToFile:filePath atomically:YES];
    } else {
        // From the cache
        imageData = [NSData dataWithContentsOfFile:filePath];
    }
    
    return [[UIImage alloc] initWithData:imageData];
}

+ (NSString *)hash:(NSString *)string
{
    const char* cstr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (int)strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
