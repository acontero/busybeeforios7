//
//  QCCell.m
//  CheckboxButtonPractice
//
//  Created by QL Mac Lab on 7/21/13.
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
        NSLog(@"task completed: %@",self.currentTask.completed);
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef soundFileURLRef;
        soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"button-3", CFSTR ("wav"), NULL);
        UInt32 soundID;
        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
        AudioServicesPlaySystemSound(soundID);
        
    }
    else{
        [_checkBoxButton setImage:[UIImage imageNamed:@"checkboxmark.png"] forState:UIControlStateNormal];
        self.currentTask.completed = [[NSNumber alloc] initWithBool:YES];
        NSLog(@"task completed: %@",self.currentTask.completed);
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef soundFileURLRef;
        soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"button-7", CFSTR ("wav"), NULL);
        UInt32 soundID;
        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
        AudioServicesPlaySystemSound(soundID);
    }

}


@end
