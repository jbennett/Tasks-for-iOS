//
//  TasksTableViewController.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "TasksTableViewController.h"
#import "Task.h"
#import "TaskCell.h"

@interface TasksTableViewController ()
@property (nonatomic, retain) NSArray *tasks;
@end

@implementation TasksTableViewController

- (id)initWithTasks:(NSArray *)tasks
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self != nil) {
        self.title = @"Tasks";
        self.tasks = tasks;
        self.toolbarItems = @[
                              [[[UIBarButtonItem alloc] initWithTitle:@"complete all"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(completeAll)] autorelease],

                              [[[UIBarButtonItem alloc] initWithTitle:@"sort by name"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(sort)] autorelease]
                              ];

        [self.tableView registerClass:[TaskCell class]
               forCellReuseIdentifier:@"TaskCell"];
    }
    return self;
}

- (void)dealloc
{
    self.tasks = nil;
    
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];

    [cell configureStyle];
    [cell setTask:[self.tasks objectAtIndex:[indexPath row]]];

    Task *task = [self.tasks objectAtIndex:[indexPath row]];
    if ([task.childrenTasks count] > 0)
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    else
        [cell setAccessoryType:UITableViewCellAccessoryNone];

    if (task.completed) {
        [cell setInactive];
    }

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    [[cell task] switchDone];

    if ([[cell task] completed]) {
        [cell setInactive];
    } else {
        [[cell textLabel] setTextColor:[UIColor blackColor]];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView cellForRowAtIndexPath:indexPath];

    TasksTableViewController *tvc = [[[TasksTableViewController alloc] initWithTasks:[[cell task] childrenTasks]] autorelease];
    tvc.title = [[cell task] title];

    [self.navigationController pushViewController:tvc animated:YES];
}

- (void)completeAll
{
    for (UITableViewCell *cell in self.tableView.visibleCells) {

        if (![[(TaskCell *)cell task] completed]) {
            [(TaskCell *)cell setInactive];
            [[(TaskCell *)cell task] switchDone];
        }
    }
}

- (void)sort
{
    self.tasks = [self.tasks sortedArrayUsingSelector:@selector(title)];

    // This would look much nicer with animations, wouldn't it? :)
    [self.tableView reloadData];
}

@end
