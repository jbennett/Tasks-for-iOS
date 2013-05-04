//
//  Task.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "Task.h"

#define NOW [NSDate date]

@implementation Task

- (Task*)init
{
    return [self initWithTitle:@"<no title>"];
}

- (Task *)initWithTitle:(NSString*)name
{
    if (self = [super init]) {
        self.title = name;
        self.modified = 0;
    }
    
    return self;
}

-(void)dealloc
{
    [self.childrenTasks removeAllObjects];
    
}

- (void)setTitle: (NSString *)title
{
    self.modified = NOW;
    _title = title;
}

-(NSString *)modifiedString
{
    NSCalendar* cal = [[NSCalendar alloc] init];
    NSString* ret;
    if (self.modified) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setCalendar:cal];
        ret = [formatter stringFromDate:self.modified];
    } else {
        return @"not yet modified";
    }

    return ret;
}


- (void)addChild:(Task*)child
{
    self.modified = NOW;
    [self.childrenTasks addObject:child];
    [child setParentTask:self];
}

- (void)removeChild:(Task*)child
{
    [self.childrenTasks removeObject:child];
}


- (void)toggleCompleted
{
    self.completed = !self.completed;
}

- (void)switchDone
{
    [self toggleCompleted];
}

- (BOOL)notCompleted
{
    return !self.completed;
}

- (void) makeAllChildrenComplete;
{
    for (int l=0;l!=self.childrenTasks.count;l=l++) {
        if ([[self.childrenTasks objectAtIndex:l] notCompleted]) {
            [[self.childrenTasks objectAtIndex:l] switchDone];
        }
    }
}

- (void)deleteChildren;
{
    for(int l=0;l<=self.childrenTasks.count;l=l++) {
        [self.childrenTasks removeObjectAtIndex:l];
    }
}

@end
