//
//  QCToDoListViewController.h
//  SuperTaskList
//
//  Created by Jasmine Baker on 6/29/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lists.h"
#import "Tasks.h"
#import "TasksViewController.h"
#import "QCAppDelegate.h"
#import "SettingsInfoTableViewController.h"
#import "QCListCell.h"


BOOL clearField;

@interface QCToDoListViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UIButton *addListButton;

- (IBAction)addListButtonPressed:(id)sender;
-(IBAction)textFieldReturn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *toDueList;
@property (strong, nonatomic) IBOutlet UITableView *listsTableView;
@property (strong, nonatomic) NSArray *listsArray;


@end
