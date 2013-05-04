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
@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) NSIndexPath *lastSelectedPath;
@end

@implementation TasksTableViewController

- (id)initWithTasks:(NSArray *)tasks
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self != nil) {
        self.title = @"Tasks";
        self.tasks = [tasks mutableCopy];
        self.toolbarItems = @[
                              [[UIBarButtonItem alloc] initWithTitle:@"complete all"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(completeAll)],

                              [[UIBarButtonItem alloc] initWithTitle:@"sort by name"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(sort)]
                              ];
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem;

        [self.tableView registerClass:[TaskCell class]
               forCellReuseIdentifier:@"TaskCell"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.lastSelectedPath) {
        [self.tableView reloadRowsAtIndexPaths:@[self.lastSelectedPath] withRowAnimation:UITableViewRowAnimationNone];
        self.lastSelectedPath = nil;
    }
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];

    [cell configureStyle];
    [cell setTask:[self.tasks objectAtIndex:[indexPath row]]];

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
        [cell setActive];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    self.lastSelectedPath = indexPath;

    TasksTableViewController *tvc = [[TasksTableViewController alloc] initWithTasks:[[cell task] childrenTasks]];
    tvc.title = [[cell task] title];

    [self.navigationController pushViewController:tvc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            [self.tasks removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            break;
            
        default:
            break;
    }
}

#pragma mark - Actions
- (void)completeAll
{
    [self.tasks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Task *task = (Task *)obj;
        if (![task.childrenTasks count]) {
            [task setCompleted:YES];
        }
    }];
    
    [self.tableView reloadData];
}

- (void)sort
{
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    NSArray *oldTasks = [self.tasks copy];
    self.tasks = [[self.tasks sortedArrayUsingDescriptors:@[sort]] mutableCopy];
    
    // animate change
    [self.tableView beginUpdates];
    [oldTasks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int newIndex = [self.tasks indexOfObject:obj];
        [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]
                               toIndexPath:[NSIndexPath indexPathForItem:newIndex inSection:0]];
    }];
    [self.tableView endUpdates];
}

@end
