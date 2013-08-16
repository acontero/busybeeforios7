//
//  CategoryViewController.h
//  SuperTaskList
//
//  Created by Donysa Vacharasanee on 7/13/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditTaskViewController.h"

@interface CategoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *addNewCategoryButton;
- (IBAction)addNewCategoryButtonPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *enterNewCategoryTextField;

@end
