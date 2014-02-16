//
//  QCDateViewController.m
//  datePicker
//
//  Created by Hasan Priyo on 7/13/13.
//  Copyright (c) 2013 Hasan Priyo. All rights reserved.
//

#import "QCDateViewController.h"

@interface QCDateViewController ()
@end
@implementation QCDateViewController
@synthesize myPicker;



- (void)viewDidLoad
{
    NSLog(@"Reached this point!");
    [super viewDidLoad];
     NSLog(@"Reached this point too");
    self.myPicker.hidden=YES;
    myPicker.datePickerMode = UIDatePickerModeDate;
    //[self showView];
    
    //FOR TITLE IMAGE
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar-date.png"]];
    
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
    
    if(self.currentTaskToAssignDate.duedate){
        myPicker.date = self.currentTaskToAssignDate.duedate;
    }
    [self showView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [UIView animateWithDuration:1.0
                     animations:^{
                         myPicker.frame = CGRectMake(0, 152, 320, 260);
                     }];
   
}

-(void)goToPreviousView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
}

- (void) showView

{
    self.myPicker.hidden=NO;
    self.isPickerShowing=YES;
    [self.view addSubview:myPicker];
    myPicker.frame = CGRectMake(0, -250, 320, 50);
    
    [self.view addSubview:myPicker];
}

- (IBAction)chooseDate:(id)sender
{        
    NSDate *date = [myPicker date];
    
    self.currentTaskToAssignDate.duedate = date;
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
