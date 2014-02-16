//
//  QCListCell.h
//  CheckboxButtonPractice
//
//  Created by Jasmine Baker on 7/21/13.
//  Copyright (c) 2013 Jasmine Baker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Lists.h"

@interface QCListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *listName;
@property (strong, nonatomic) Tasks *currentList;

@end
