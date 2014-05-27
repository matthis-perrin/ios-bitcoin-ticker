//
//  ExchangeUIViewController.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "ExchangeUIViewController.h"
#import "ExchangeManager.h"
#import "DateUtils.h"

@interface ExchangeUIViewController ()

@end


@implementation ExchangeUIViewController

@synthesize tileView;
@synthesize imageView;
@synthesize priceLabel;
@synthesize timeLabel;

@synthesize exchange;
@synthesize lastTicker;


- (id) initWithExchange:(Exchange*)_exchange
{
    self = [super init];
    if (self) {
        exchange = _exchange;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    tileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tile.png"]];
    tileView.contentMode = UIViewContentModeCenter;

    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:exchange.imageName]];
    imageView.contentMode = UIViewContentModeCenter;

    priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"Connecting...";
    priceLabel.textColor = [UIColor colorWithWhite:102.0f/255.0f alpha:1.0f];
    priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35.0f];
    priceLabel.textAlignment = NSTextAlignmentCenter;

    timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"";
    timeLabel.textColor = [UIColor colorWithWhite:180.0f/255.0f alpha:1.0f];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont systemFontOfSize:12.0f];

    [self.view addSubview:tileView];
    [self.view addSubview:imageView];
    [self.view addSubview:priceLabel];
    [self.view addSubview:timeLabel];

    [self updateConstraints];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [ExchangeManager startExchange:exchange.type block:^(Ticker* ticker) {
            [self updateWithTicker:ticker];
        }];
    });

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateDate) userInfo:nil repeats:YES];
}

- (void) updateConstraints
{
    tileView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tileView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tileView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tileView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tileView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0.0f]];

    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:25.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0f]];

    priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:priceLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-30.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:priceLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0f]];

    timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:timeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:15.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:timeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-21.0f]];
}

- (void) updateWithTicker:(Ticker*)ticker
{
    [self performSelectorOnMainThread:@selector(updateUIWithTicker:) withObject:ticker waitUntilDone:NO];
}

- (void) updateUIWithTicker:(Ticker*)ticker
{
    NSString* bidString = [NSString stringWithFormat:@"%.2f", ticker.bid];
    NSString* askString = [NSString stringWithFormat:@"%.2f", ticker.ask];
    [priceLabel setText:[NSString stringWithFormat:@"%@ / %@", bidString, askString]];
    [timeLabel setText:[DateUtils timeFromNow:ticker.date]];
    lastTicker = ticker;
}

- (void) updateDate {
    if (lastTicker == nil) { return; }
    NSString* newText = [DateUtils timeFromNow:lastTicker.date];
    if (![newText isEqualToString:timeLabel.text]) {
        [timeLabel setText:newText];
    }
}

@end
