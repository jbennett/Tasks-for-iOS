//
//  TaskCell.h
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Task.h"

@interface TaskCell : UITableViewCell

@property (nonatomic, retain) Task *task;

- (void)configureStyle;
- (void)setActive;
- (void)setInactive;

@end
