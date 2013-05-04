//
//  Task.h
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject {
    NSDate *modified;
    BOOL *done;
}

- (Task*)init;
- (Task*)initWithTitle:(NSString*)name;

- (void)setModified: (NSDate *)date;

@property(nonatomic,retain) NSString* title;

-(void) setTitle:(NSString *)title;

-(NSDate *)modifiedDate;
-(NSString *)modifiedString;

// Children
@property (retain) NSMutableArray* childrenTasks;
@property (retain) id parentTask;
- (void)addChild:(Task*)child;
- (void)removeChild:(Task*)child;

// Completed
-(BOOL)completed;
- (BOOL)notCompleted;
- (void)switchDone;

- (void)makeAllChildrenComplete;
- (void)deleteChildren;


@end




