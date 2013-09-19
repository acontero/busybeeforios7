//
//  TasksListViewController.m
//  SuperTaskList
//
//  Created by Donysa Vacharasanee on 6/16/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import "TasksViewController.h"

@interface TasksViewController ()

@end

@implementation TasksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
    //FOR TITLE IMAGE
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar-busybee.png"]];
    
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
    
    //EDIT BUTTON
    UIImage *editImage = [UIImage imageNamed:@"navbar-editbutton.png"];
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setBackgroundImage: [editImage stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateNormal];
    //    [button setBackgroundImage: [[UIImage imageNamed: @"right_clicked.png"] stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    editButton.frame= CGRectMake(0.0, 0.0, editImage.size.width, editImage.size.height);
    UIView *editView=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, editImage.size.width, editImage.size.height) ];
    [editButton addTarget:self action:@selector(setEditing:animated:) forControlEvents:UIControlEventTouchUpInside];
    [editView addSubview:editButton];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithCustomView:editView];
    self.navigationItem.rightBarButtonItem= edit;

    self.textLabel.delegate=self;
   
}


-(void)goToPreviousView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewDidAppear:(BOOL) animated
{
    [super viewDidAppear:YES];
    //self.tasksArray = [Tasks findAll];
    self.tasksArray = [Tasks findByAttribute:@"list" withValue:self.currentList];
    
    
    //After we setup our "Data source" we call the method reload on our tableView object so that the tableview will properly display the appropriate information.
    [self.taskTableView reloadData];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasksArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellidentifier = @"QCCell";
    QCCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QCCell" owner:self options: nil];
        cell = [nib objectAtIndex:0];
    }
    cell.currentTask = [self.tasksArray objectAtIndex:indexPath.row];
    cell.taskName.text = [[self.tasksArray objectAtIndex:indexPath.row] taskTitle];
    
    //if dueDate exists, display it under task name
    if([[self.tasksArray objectAtIndex:indexPath.row] duedate]){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/YYYY"];
        NSString *dateString = [dateFormat stringFromDate: [[self.tasksArray objectAtIndex:indexPath.row] duedate]];
        cell.dueDateLabel.text = [NSString stringWithFormat:@"Due: %@",dateString];
    }
    
    NSNumber *checked = [[self.tasksArray objectAtIndex:indexPath.row] completed];
    
    if ([checked isEqualToNumber:[[NSNumber alloc] initWithBool:YES]]) {
        [cell.checkBoxButton setImage:[UIImage imageNamed:@"checkboxmark.png"] forState:UIControlStateNormal];
    }
    else{
        [cell.checkBoxButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    }
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //After the user touches the row, deselect the row
    
    EditTaskViewController *editTaskVC = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"editTaskPage"];
    editTaskVC.taskToBeEdited = [self.tasksArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:editTaskVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UITextFieldDelegate

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskButtonPressed:(id)sender
{
    Tasks *task = [Tasks createEntity];
    task.taskTitle = self.textLabel.text;
    task.list = self.currentList;
    // [self.tasksArray addObject:self.textLabel.text];
    task.list = self.currentList;
    task.completed = NO;
    //self.tasksArray = [Tasks findAll];
    self.tasksArray = [Tasks findByAttribute:@"list" withValue:self.currentList];
    
    
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    [self.taskTableView reloadData];
    
    self.textLabel.text = @"";

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        Tasks *taskToBeDeleted = self.tasksArray[indexPath.row];
        [taskToBeDeleted MR_deleteEntity];
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        self.tasksArray = [Tasks findByAttribute:@"list" withValue:self.currentList];;
        [tableView reloadData];
    }
    
}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.taskTableView setEditing:editing animated:animated];
    
    //DONE BUTTON
    UIImage *doneImage = [UIImage imageNamed:@"done.png"];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundImage: [doneImage stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateNormal];
    //    [button setBackgroundImage: [[UIImage imageNamed: @"right_clicked.png"] stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    doneButton.frame= CGRectMake(0.0, 0.0, doneImage.size.width, doneImage.size.height);
    UIView *doneView=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, doneImage.size.width, doneImage.size.height) ];
    [doneButton addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventTouchUpInside];
    [doneView addSubview:doneButton];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithCustomView:doneView];
    self.navigationItem.rightBarButtonItem= done;
    
    
    [super setEditing:editing animated:animated];

}

-(void) endEditing
{
    [self setEditing:NO animated:YES];
    //EDIT BUTTON
    UIImage *editImage = [UIImage imageNamed:@"navbar-editbutton.png"];
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setBackgroundImage: [editImage stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateNormal];
    //    [button setBackgroundImage: [[UIImage imageNamed: @"right_clicked.png"] stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    editButton.frame= CGRectMake(0.0, 0.0, editImage.size.width, editImage.size.height);
    UIView *editView=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, editImage.size.width, editImage.size.height) ];
    [editButton addTarget:self action:@selector(setEditing:animated:) forControlEvents:UIControlEventTouchUpInside];
    [editView addSubview:editButton];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithCustomView:editView];
    self.navigationItem.rightBarButtonItem= edit;
    
    
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}





@end
