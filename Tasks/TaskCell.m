//
//  TaskCell.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "TaskCell.h"
#import "UIImage+NamedImages.h"

#define CHECKMARKVIEW 100

@interface TaskCell ()

- (UIImageView *)checkboxImageView;

@end

@implementation TaskCell

- (void)configureStyle
{
    self.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:16];
    self.textLabel.textColor = [UIColor blackColor];
}


- (void)setTask:(Task *)task
{
    _task = task;
    self.textLabel.text = task.title;
}

- (void)setActive
{
    self.textLabel.textColor = [UIColor blackColor];
    [self checkboxImageView].image = [UIImage uncheckedImage];
}

- (void)setInactive
{
    self.textLabel.textColor = [UIColor lightGrayColor];
    [self checkboxImageView].image = [UIImage checkedImage];
}

- (UIImageView *)checkboxImageView
{
    return (UIImageView *)[self viewWithTag:CHECKMARKVIEW];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // Configure Image View
    UIImageView *imageView = [self checkboxImageView];
    if (imageView == nil) {
        imageView = [[[UIImageView alloc] initWithImage:[UIImage checkedImage]] autorelease];
        imageView.tag = CHECKMARKVIEW;
    }

    imageView.bounds = CGRectMake(0, 0, 40, self.bounds.size.height);
    [self addSubview:imageView];

    // Configure Title
    CGRect r = self.textLabel.bounds;
    r.origin.x = 40;
    self.textLabel.frame = r;

    // Switch Image
    if (_task.completed) {
        imageView.image = [UIImage checkedImage];
    } else {
        imageView.image = [UIImage uncheckedImage];
    }
}


@end