//
//  QCAddTaskViewController.m
//  SuperTaskList
//
//  Created by Jonathan Zhu on 6/16/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import "EditTaskViewController.h"
#import "QCDateViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //ATTTEMPT TO ADD POST IT IMAGE
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sticky_note.jpg"]];
    
//    self.taskDescriptionTextView = [[UITextView alloc]initWithFrame: window.frame];
    
//    UIImageView *imgView = [[UIImageView alloc]initWithFrame: self.taskDescriptionTextView.frame];
//    imgView.image = [UIImage imageNamed: @"sticky_note.jpg"];
//    [self.taskDescriptionTextView addSubview: imgView];
//    [self.taskDescriptionTextView sendSubviewToBack: imgView];
    
//    [window addSubview: textView];
    
    //FOR TITLE IMAGE
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar-edit.png"]];
    
    //BACK BUTTON
    UIImage *backImage = [UIImage imageNamed:@"navbar-cancel.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage: [backImage stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateNormal];
//    [button setBackgroundImage: [[UIImage imageNamed: @"right_clicked.png"] stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    backButton.frame= CGRectMake(0.0, 0.0, backImage.size.width, backImage.size.height);
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, backImage.size.width, backImage.size.height) ];
    [backButton addTarget:self action:@selector(goToPreviousView) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:backButton];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:v];
    self.navigationItem.leftBarButtonItem= back;
    
    //SAVE BUTTON
    UIImage *saveImage = [UIImage imageNamed:@"navbar-save.png"];
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setBackgroundImage: [saveImage stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateNormal];
    //    [button setBackgroundImage: [[UIImage imageNamed: @"right_clicked.png"] stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    saveButton.frame= CGRectMake(0.0, 0.0, saveImage.size.width, saveImage.size.height);
    UIView *saveView=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, saveImage.size.width, saveImage.size.height) ];
    [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [saveView addSubview:saveButton];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:saveView];
    self.navigationItem.rightBarButtonItem= save;
    
        
    NSLog(@"set savebutton in view did load editTasKVC");
    
//    self.navigationItem.title = @"Edit Task";
}

-(void)goToPreviousView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/YYYY"];
    NSString *dateString = [dateFormat stringFromDate: self.taskToBeEdited.duedate];
    NSLog(@"dateString: %@",dateString);
    self.dueDateLabel.text = dateString;
    NSLog(@"date in editTaskVC: %@",self.taskToBeEdited.duedate);
    self.taskDescriptionTextView.text = self.taskToBeEdited.taskdescription;
}

//Not working...
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSLog(@"return button pressed");
////    [self.taskTextField resignFirstResponder];
////    [self.dateDueTextField resignFirstResponder];
//    
//    return YES;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

//THIS METHOD IS NOT SAVING!!!
-(void)saveButtonPressed:(id)sender
{
    self.taskToBeEdited.taskdescription = self.taskDescriptionTextView.text;
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QCDateViewController * controller = (QCDateViewController *)segue.destinationViewController;
    controller.currentTaskToAssignDate = self.taskToBeEdited;

}


@end
