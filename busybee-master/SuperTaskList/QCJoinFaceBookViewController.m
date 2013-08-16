//
//  QCJoinFaceBookViewController.m
//  settingPage
//
//  Created by Hasan Priyo on 7/16/13.
//  Copyright (c) 2013 Hasan Priyo. All rights reserved.
//

#import "QCJoinFaceBookViewController.h"

@interface QCJoinFaceBookViewController ()

@end

@implementation QCJoinFaceBookViewController
@synthesize faceBookView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *fullURL = @"http://facebook.com";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [faceBookView loadRequest:requestObj];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
