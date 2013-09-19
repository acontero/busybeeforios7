//
//  QCCell.m
//  CheckboxButtonPractice
//
//  Created by Jasmine Baker on 7/21/13.
//  Copyright (c) 2013 Jasmine Baker. All rights reserved.
//

#import "QCCell.h"

@implementation QCCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkButton:(id)sender {

    if ([self.currentTask.completed isEqualToNumber:[[NSNumber alloc] initWithBool:YES]]) {
       [ _checkBoxButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        self.currentTask.completed = [[NSNumber alloc] initWithBool:NO];
    }
    else{
        [_checkBoxButton setImage:[UIImage imageNamed:@"checkboxmark.png"] forState:UIControlStateNormal];
        self.currentTask.completed = [[NSNumber alloc] initWithBool:YES];
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef soundFileURLRef;
        soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"buzzshort", CFSTR ("m4a"), NULL);
        UInt32 soundID;
        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
        AudioServicesPlaySystemSound(soundID);
    }

}


@end
