//
//  TaskCell.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "TaskCell.h"

#define CHECKMARKVIEW 100

@implementation TaskCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    return self;
}

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


- (void)setInactive; {
    self.textLabel.textColor = [UIColor lightGrayColor];
}



- (UIView *)subviewForTag:(NSInteger)tag {
    for (UIView *subview in self.subviews) {
        if (subview.tag == tag) return subview;
    }

    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // Configure Image View
    UIImageView *imageView = (UIImageView *)[self subviewForTag:CHECKMARKVIEW];
    if (imageView == nil) {
        imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkbox-Empty.png"]] autorelease];
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
        imageView.image = [UIImage imageNamed:@"Checkbox-Checked.png"];
    } else {
        imageView.image = [UIImage imageNamed:@"Checkbox-Empty.png"];
    }
}


@end