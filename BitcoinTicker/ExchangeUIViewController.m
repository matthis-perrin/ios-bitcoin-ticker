//
//  ExchangeUIViewController.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "ExchangeUIViewController.h"

@interface ExchangeUIViewController ()

@end


@implementation ExchangeUIViewController

@synthesize tileView;
@synthesize imageView;
@synthesize priceLabel;

@synthesize exchange;

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
    priceLabel.text = @"Loading...";
    priceLabel.center = self.view.center;
    priceLabel.textColor = [UIColor colorWithWhite:102.0f/255.0f alpha:1.0f];
    priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35.0f];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tileView];
    [self.view addSubview:imageView];
    [self.view addSubview:priceLabel];
    
    [self updateConstraints];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateWithBid:579.05 Ask:581.16];
    });
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
}

- (void) updateWithBid:(float)bid Ask:(float)ask
{
    NSString* bidString = [NSString stringWithFormat:@"%.2f", bid];
    NSString* askString = [NSString stringWithFormat:@"%.2f", ask];
    [priceLabel setText:[NSString stringWithFormat:@"%@ / %@", bidString, askString]];
}

@end
