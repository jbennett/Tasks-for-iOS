//
//  Task.h
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSDate* modified;
@property (nonatomic, assign, getter = isCompleted) BOOL completed;
@property (strong) NSMutableArray* childrenTasks;
@property (strong) id parentTask;

- (Task*)init;
- (Task*)initWithTitle:(NSString*)name;

-(NSString *)modifiedString;

// Children
- (void)addChild:(Task*)child;
- (void)removeChild:(Task*)child;
- (void)makeAllChildrenComplete;
- (void)deleteChildren;

// Completed
- (BOOL)notCompleted;
- (void)toggleCompleted;
- (void)switchDone __attribute__((deprecated));

@end




