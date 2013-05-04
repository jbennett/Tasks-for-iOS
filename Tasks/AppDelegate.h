//
//  AppDelegate.h
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TasksTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) TasksTableViewController *tasksTableViewController;

@end
