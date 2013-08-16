//
//  QCAddTaskViewController.h
//  SuperTaskList
//
//  Created by Jonathan Zhu on 6/16/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasksViewController.h"
#import "Tasks.h"
#import "CategoryViewController.h"

@interface EditTaskViewController : UITableViewController
<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;


@property (strong, nonatomic) IBOutlet UITableViewCell *dueDateCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *reminderCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *taskCategoryCell;

@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;

@property (strong, nonatomic) Tasks *taskToBeEdited;

@end
