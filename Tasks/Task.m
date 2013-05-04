//
//  Task.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "Task.h"

#define NOW [NSDate date]

@implementation Task
@synthesize title;
@synthesize childrenTasks;


- (Task*)init
{
    return [self initWithTitle:@"<no title>"];
}

- (Task *)initWithTitle:(NSString*)name
{
    if (self = [super init]) {
        title = name;
        modified = 0;
    }
    
    return self;
}

-(void)dealloc
{
    [childrenTasks removeAllObjects];
    
}

- (void)setTitle: (NSString *) t
{
    modified = NOW;
    self.title = t;
}


- (void)setModified: (NSDate *)date;
{
    modified = date;
}


-(NSDate*)modifiedDate; {
    return modified;
}

-(NSString *)modifiedString
{
    NSCalendar* cal = [[NSCalendar alloc] init];
    NSString* ret;
    if(modified) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setCalendar:cal];
        ret = [formatter stringFromDate:modified];
    } else {
        return @"not yet modified";
    }

    return ret;
}


- (void)addChild:(Task*)child
{
    modified = NOW;
    [childrenTasks addObject:child];
    [child setParentTask:self];
}

- (void)removeChild:(Task*)child
{
    [childrenTasks removeObject:child];
}

- (void)setCompleted:(BOOL)completed
{
    done = completed;
}

- (void)switchDone
{
    done = !done;
}

-(BOOL)completed {
    return done;
}

- (BOOL)notCompleted;
{
    return !done;
}

- (void) makeAllChildrenComplete;
{
    for(int l=0;l!=childrenTasks.count;l=l++) {
        if ([[childrenTasks objectAtIndex:l] notCompleted]) {
            [[childrenTasks objectAtIndex:l] switchDone];
        }
    }
}

- (void)deleteChildren;
{
    for(int l=0;l<=childrenTasks.count;l=l++) {
        [childrenTasks removeObjectAtIndex:l];
    }
}

@end
