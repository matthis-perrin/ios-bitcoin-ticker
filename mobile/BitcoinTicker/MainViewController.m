//
//  ViewController.m
//  BitcoinTicker
//
//  Created by Matthis Perrin on 5/25/14.
//  Copyright (c) 2014 Bitcoin. All rights reserved.
//

#import "MainViewController.h"
#import "ExchangeManager.h"
#import "ExchangeUIViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    
    ExchangeManager* exchangeManager;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    exchangeManager = [[ExchangeManager alloc] init];
    [exchangeManager start];
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.backgroundColor = [UIColor colorWithWhite:238.0f/255.0f alpha:1.0f];
    
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = scrollView.center;
    [activityIndicator startAnimating];
    [scrollView addSubview:activityIndicator];
    
    [ExchangeManager registerForMetaData:^(NSDictionary* metadata) {
        int exchangeCount = 0;
        
        int margin = 6;
        int start = 20 + margin;
        int width = 320;
        int height = 210;
        
        for (NSString* exchangeName in metadata) {
            NSDictionary* exchangeMetadata = [metadata objectForKey:exchangeName];
            Exchange* exchange = [[Exchange alloc] initWithName:exchangeName image:[exchangeMetadata objectForKey:@"image"]];
            int exchangeIndex = [[exchangeMetadata objectForKey:@"index"] intValue];
            
            ExchangeUIViewController* exchangeViewController = [[ExchangeUIViewController alloc] initWithExchange:exchange];
            exchangeViewController.view.frame = CGRectMake(0, start + exchangeIndex * height, width, height);
            [scrollView addSubview:exchangeViewController.view];
            
            exchangeCount++;
        }
        
        scrollView.contentSize = CGSizeMake(width, start + exchangeCount * height + margin);
        [activityIndicator removeFromSuperview];
    }];
    
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
