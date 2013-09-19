//
//  QCToDoListViewController.m
//  SuperTaskList
//
//  Created by Jasmine Baker on 6/29/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import "QCToDoListViewController.h"


@interface QCToDoListViewController ()

@end

@implementation QCToDoListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //FOR TITLE IMAGE
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar-busybee.png"]];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //INFO BUTTON
    UIImage *saveImage = [UIImage imageNamed:@"info.png"];
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setBackgroundImage: [saveImage stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateNormal];
    //    [button setBackgroundImage: [[UIImage imageNamed: @"right_clicked.png"] stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    saveButton.frame= CGRectMake(0.0, 0.0, saveImage.size.width, saveImage.size.height);
    UIView *saveView=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, saveImage.size.width, saveImage.size.height) ];
    [saveButton addTarget:self action:@selector(pushTaskView) forControlEvents:UIControlEventTouchUpInside];
    [saveView addSubview:saveButton];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:saveView];
    self.navigationItem.rightBarButtonItem= save;

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
    self.navigationItem.leftBarButtonItem= edit;
    
    self.toDueList.delegate=self;
    self.listsTableView.delegate=self;
    self.listsTableView.dataSource=self;
    self.listsArray = [[NSArray alloc] init];
    
}

-(void)pushTaskView{
    SettingsInfoTableViewController *infoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"infoPage"];
    [self.navigationController pushViewController:infoVC animated:YES];
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    self.listsArray = [Lists findAllSortedBy:@"nameTitle" ascending:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isNotFirstTimeUser = [userDefaults boolForKey:firstTimeUser];
    
    if (!isNotFirstTimeUser) {
        [self createDefaultList];
    }
    [self.listsTableView reloadData];
}
-(void)createDefaultList{
    
    Lists *mylist = [Lists createEntity];
    mylist.nameTitle= @"Everyday To-Do List (Default)";
    
    [[NSManagedObjectContext MR_contextForCurrentThread]MR_saveToPersistentStoreAndWait];

    self.listsArray = [Lists findAllSortedBy:@"nameTitle" ascending:YES];

    [self.listsTableView reloadData];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    [standardUserDefaults setBool:YES forKey:firstTimeUser];
    [standardUserDefaults synchronize];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listsArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Thonburi" size:17.0f];
    Lists  * list = self.listsArray[indexPath.row];
    cell.textLabel.text = [list nameTitle];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TasksViewController *TasksVC = [self.storyboard instantiateViewControllerWithIdentifier:@"taskViewControllerUI"];
    TasksVC.currentList=[self.listsArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:TasksVC animated:YES ];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        Lists *listToBeDeleted = self.listsArray[indexPath.row];
        [listToBeDeleted MR_deleteEntity];
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        self.listsArray = [Lists findAllSortedBy:@"nameTitle" ascending:YES];
        [self.listsTableView reloadData];
        //[tableView reloadData];
    }
    
}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated{
    
    
        [self.listsTableView setEditing:editing animated:animated];
       // [self.navigationItem.rightBarButtonItem ]
        
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
        self.navigationItem.leftBarButtonItem= done;
        
    
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
    self.navigationItem.leftBarButtonItem= edit;


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

- (IBAction)addListButtonPressed:(id)sender
{
    Lists *mylist = [Lists createEntity];
    mylist.nameTitle= self.toDueList.text;
    [[NSManagedObjectContext MR_contextForCurrentThread]MR_saveToPersistentStoreAndWait];

    self.listsArray = [Lists findAllSortedBy:@"nameTitle" ascending:YES];;
    
    [self.listsTableView reloadData];
    
    self.toDueList.text = @"";
}

@end
