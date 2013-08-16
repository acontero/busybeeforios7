//
//  QCEmailUsViewController.h
//  settingPage
//
//  Created by Hasan Priyo on 7/16/13.
//  Copyright (c) 2013 Hasan Priyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface QCEmailUsViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)emailUs:(id)sender;

@end
