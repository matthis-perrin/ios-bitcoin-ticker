//
//  ExchangeUIViewController.h
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exchange.h"
#import "Ticker.h"

@interface ExchangeUIViewController : UIViewController

@property UIImageView* tileView;
@property UIImageView* imageView;
@property UILabel* priceLabel;
@property UILabel* timeLabel;

@property Exchange* exchange;
@property Ticker* lastTicker;

- (id) initWithExchange:(Exchange*)_exchange;

@end
