//
//  Tasks.h
//  SuperTaskList
//
//  Created by Angelica Contero Stapleton on 7/25/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lists;

@interface Tasks : NSManagedObject

@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSDate * duedate;
@property (nonatomic, retain) NSDate * reminder;
@property (nonatomic, retain) NSString * taskdescription;
@property (nonatomic, retain) NSString * taskTitle;
@property (nonatomic, retain) Lists *list;

@end
