//
//  ViewController.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "MainViewController.h"
#import "ExchangeUIViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.backgroundColor = [UIColor colorWithWhite:238.0f/255.0f alpha:1.0f];
    
    int margin = 6;
    int start = 20 + margin;
    int width = 320;
    int height = 210;
    
    NSArray* exchangeArray = @[
       [[Exchange alloc] initWithType:BUTTERCOIN name:@"Buttercoin" image:@"buttercoin.png"],
       [[Exchange alloc] initWithType:BITSTAMP name:@"Bitstamp" image:@"bitstamp.png"],
       [[Exchange alloc] initWithType:COINBASE name:@"Coinbase" image:@"coinbase.png"],
    ];
    
    for (int i = 0; i < exchangeArray.count; i++) {
        ExchangeUIViewController* exchangeViewController = [[ExchangeUIViewController alloc] initWithExchange:exchangeArray[i]];
        exchangeViewController.view.frame = CGRectMake(0, start + i * height, width, height);
        [scrollView addSubview:exchangeViewController.view];
    }
    
    scrollView.contentSize = CGSizeMake(width, start + exchangeArray.count * height + margin);
    
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
