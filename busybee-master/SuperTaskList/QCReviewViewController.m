//
//  QCReviewViewController.m
//  settingPage
//
//  Created by Hasan Priyo on 7/16/13.
//  Copyright (c) 2013 Hasan Priyo. All rights reserved.
//

#import "QCReviewViewController.h"

@interface QCReviewViewController ()

@end

@implementation QCReviewViewController

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
    //FOR TITLE IMAGE
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reviewus.png"]];
    
    //BACK BUTTON
    UIImage *backImage = [UIImage imageNamed:@"backbutton.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage: [backImage stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateNormal];
    //    [button setBackgroundImage: [[UIImage imageNamed: @"right_clicked.png"] stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    backButton.frame= CGRectMake(0.0, 0.0, backImage.size.width, backImage.size.height);
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, backImage.size.width, backImage.size.height) ];
    [backButton addTarget:self action:@selector(goToPreviousView) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:backButton];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:v];
    //        self.editButtonItem = back;
    self.navigationItem.leftBarButtonItem = back;

        
    self.review.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/busybee-todo-list/id707652885?mt=8"];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.review loadRequest:requestURL];

}

-(void)goToPreviousView{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
