//
//  ExchangeUIViewController.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "ExchangeUIViewController.h"

@interface ExchangeUIViewController ()

@property UIImageView* tileView;
@property UIImageView* imageView;
@property UILabel* bidLabel;

@end

@implementation ExchangeUIViewController

@synthesize tileView;
@synthesize imageView;
@synthesize bidLabel;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    tileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tile.png"]];
    tileView.contentMode = UIViewContentModeCenter;
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bitstamp.png"]];
    imageView.contentMode = UIViewContentModeCenter;
    
    bidLabel = [[UILabel alloc] init];
    bidLabel.text = @"585.40 / 579.92";
    bidLabel.center = self.view.center;
    bidLabel.textColor = [UIColor colorWithWhite:102.0f/255.0f alpha:1.0f];
    bidLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35.0f];
    bidLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tileView];
    [self.view addSubview:imageView];
    [self.view addSubview:bidLabel];
    
    [self updateConstraints];
}

- (void) updateConstraints
{
    tileView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tileView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tileView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tileView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tileView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0.0f]];
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:20.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0f]];
    
    bidLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bidLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-30.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bidLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0f]];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
