//
//  QCDateViewController.h
//  datePicker
//
//  Created by Hasan Priyo on 7/13/13.
//  Copyright (c) 2013 Hasan Priyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"


@interface QCDateViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *myPicker;

@property (nonatomic) BOOL isPickerShowing;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) Tasks *currentTaskToAssignDate;
- (IBAction)chooseDate:(id)sender;

@end
