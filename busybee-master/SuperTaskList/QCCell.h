//
//  QCCell.h
//  CheckboxButtonPractice
//
//  Created by Jasmine Baker on 7/21/13.
//  Copyright (c) 2013 Jasmine Baker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Tasks.h"

@interface QCCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *checkBoxButton;
- (IBAction)checkButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *taskName;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (strong, nonatomic) Tasks *currentTask;

@end
