//
//  UIImage+NamedImages.m
//  Tasks
//
//  Created by Jonathan Bennett on 2013-05-04.
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "UIImage+NamedImages.h"

@implementation UIImage (NamedImages)

+ (UIImage *)checkedImage
{
    return [UIImage imageNamed:@"Checkbox-Checked.png"];
}

+ (UIImage *)uncheckedImage
{
    return [UIImage imageNamed:@"Checkbox-Empty.png"];
}

@end
