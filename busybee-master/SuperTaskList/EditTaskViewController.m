//
//  EditTaskViewController.m
//  SuperTaskList
//
//  Created by Donysa Vacharasanee on 6/16/13.
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
//    _taskDescriptionTextView.contentInset = UIEdgeInsetsMake(0, 50, 50, 50);
    _taskDescriptionTextView.textContainerInset = UIEdgeInsetsMake(0, 7, 0, 0);
    //top, left, bottom , right

    
    //FOR TITLE IMAGE
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar-edit.png"]];
    
    //BACK BUTTON
    UIImage *backImage = [UIImage imageNamed:@"navbar-cancel.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage: [backImage stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateNormal];
    
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
    
    saveButton.frame= CGRectMake(0.0, 0.0, saveImage.size.width, saveImage.size.height);
    UIView *saveView=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, saveImage.size.width, saveImage.size.height) ];
    [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [saveView addSubview:saveButton];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:saveView];
    self.navigationItem.rightBarButtonItem= save;
    
    
}

-(void)goToPreviousView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/YYYY"];
    NSString *dateString = [dateFormat stringFromDate: self.taskToBeEdited.duedate];
   
    self.dueDateLabel.text = dateString;
    self.taskDescriptionTextView.text = self.taskToBeEdited.taskdescription;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

#pragma mark - IBActions

-(void)saveButtonPressed:(id)sender
{
    self.taskToBeEdited.taskdescription = self.taskDescriptionTextView.text;
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QCDateViewController * controller = (QCDateViewController *)segue.destinationViewController;
    controller.currentTaskToAssignDate = self.taskToBeEdited;
    self.taskToBeEdited.taskdescription = self.taskDescriptionTextView.text;
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];

}


@end
