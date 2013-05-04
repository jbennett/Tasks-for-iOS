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


- (Task*)init; {
    [super init];

    title = @"<no title>";
    modified = 0;
    return self;
}
- (Task *)initWithTitle:(NSString*)name;
{
    [super init];
    title = name;
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
    title = nil;
    [childrenTasks removeAllObjects];
}
- (void)setTitle: (NSString *) t; {
    modified = NOW;
    [title release];
    self.title = [t retain];
}


- (void)setModified: (NSDate *)date;
{
    modified = date;
}


-(NSDate*)modifiedDate; {
    return modified;
}
-(NSString *)modifiedString;
{
    NSCalendar* cal = [[NSCalendar alloc] init];
    NSString* ret;
    if(modified)
    {
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setCalendar:cal];
        ret = [[f stringFromDate:modified] retain];
        [cal release];
    }else
        return @"not yet modified";

    return [ret autorelease];
}


- (void)addChild:(Task*)child;
{
    modified = NOW;
    [childrenTasks addObject:child];
    [child setParentTask:self];
}

- (void)removeChild:(Task*)child { [childrenTasks removeObject:child]; }


- (void)switchDone;
{
    BOOL newDone = NO;
    if (done)
        done = newDone;
    else
        newDone = YES;

    done = newDone;
}

-(BOOL)completed; {
    if (done) return YES;
    else return NO;
}
- (BOOL)notCompleted;
{
    if (!done)
        return NO;
    else return YES;

}



- (void) makeAllChildrenComplete;
{
    for(int l=0;l!=childrenTasks.count;l=l++)
        if ([[childrenTasks objectAtIndex:l] notCompleted])
            [[childrenTasks objectAtIndex:l] switchDone];
}
- (void)deleteChildren;
{
    for(int l=0;l<=childrenTasks.count;l=l++) {
        [childrenTasks removeObjectAtIndex:l];
    }
}


@end







