//
//  QCSettingsViewController.h
//  SuperTaskList
//
//  Created by QL Mac Lab on 6/22/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QCSettingsViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *settingsVC;
@end
