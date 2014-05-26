//
//  ExchangeUIViewController.h
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exchange.h"

@interface ExchangeUIViewController : UIViewController

@property UIImageView* tileView;
@property UIImageView* imageView;
@property UILabel* priceLabel;

@property Exchange* exchange;

- (id) initWithExchange:(Exchange*)_exchange;
- (void) updateWithBid:(float)bid Ask:(float)ask;

@end
