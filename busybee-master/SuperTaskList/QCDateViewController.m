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
    [super viewDidLoad];
    self.myPicker.hidden=YES;
    myPicker.datePickerMode = UIDatePickerModeDate;
        
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

-(void)goToPreviousView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   

}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
}

- (void) showView

{
    NSLog(@"showView");
    self.myPicker.hidden=NO;
    self.isPickerShowing=YES;
    [self.view addSubview:myPicker];
    myPicker.frame = CGRectMake(0, -250, 320, 50);
    [UIView animateWithDuration:1.0
                     animations:^{
                         myPicker.frame = CGRectMake(0, 152, 320, 260);
                     }];
}

//THIS METHOD IS NOT SAVING!!!
- (IBAction)chooseDate:(id)sender
{        
    NSDate *date = [myPicker date];
    
    self.currentTaskToAssignDate.duedate = date;
    //self.currentTaskToAssignDate.duedate = dateString;
    NSLog(@"self.taskToBeEdited.duedate from QCDateVC = %@",self.currentTaskToAssignDate.duedate);
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
