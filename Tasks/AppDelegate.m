//
//  AppDelegate.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "AppDelegate.h"
#import "Task.h"
#import "TasksTableViewController.h"

NSString *kTitle = @"title";
NSString *kCompleted = @"completed";
NSString *kChildren = @"children";


@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    self.tasksTableViewController = [[[TasksTableViewController alloc] initWithTasks:[self _generateTasks]] autorelease];
    
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:self.tasksTableViewController] autorelease];
    self.navigationController.toolbarHidden = NO;
    
    [self.window setRootViewController:self.navigationController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (NSArray *)_generateTasks
{
    NSArray *taskDescriptions =
    @[
      @{ kTitle     : @"Buy milk",
         kCompleted : @NO },

      @{ kTitle     : @"Pay rent",
         kCompleted : @NO },

      @{ kTitle     : @"Change tires",
         kCompleted : @NO },

      @{ kTitle     : @"Sleep",
         kCompleted : @NO,
         kChildren  :
             @[
                 @{ kTitle     : @"Find a bed",
                    kCompleted : @NO
                    },

                 @{ kTitle     : @"Lie down",
                    kCompleted : @NO
                    },

                 @{ kTitle     : @"Close eyes",
                    kCompleted : @NO
                    },

                 @{ kTitle     : @"Wait",
                    kCompleted : @NO
                    }
                 ] },

      @{ kTitle     : @"Dance",
         kCompleted : @NO },

      ];

    return [self _tasksFromDescriptions:taskDescriptions];
}

- (NSArray *)_tasksFromDescriptions:(NSArray *)taskDescriptions
{
    NSMutableArray *tasks = [NSMutableArray array];

    for (NSDictionary *taskDescription in taskDescriptions) {

        NSString *title = [taskDescription objectForKey:kTitle];
        BOOL completed = [[taskDescription objectForKey:kCompleted] boolValue];
        NSArray *childrenDescriptions = [taskDescription objectForKey:kChildren];


        Task *task = [[[Task alloc] initWithTitle:title] autorelease];
        task.childrenTasks = [NSMutableArray array];
        if (completed != task.completed) [task switchDone];

        if (childrenDescriptions != nil && childrenDescriptions.count > 0) {
            NSArray *children = [self _tasksFromDescriptions:childrenDescriptions];
            for (Task *child in children) {
                [task addChild:child];
                // NSLog(@"adding"); // don't need to log
            }
        }

        [tasks addObject:task];
    }
    
    return tasks;
}


@end
