//
//  NSImage+Resize.m
//  WeixinHistory
//
//  Created by XCC on 12/7/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "NSImage+Resize.h"

@implementation NSImage (Resize)

- (NSImage *)resizedImage:(NSSize)size
{
    NSImage *newImage = [[NSImage alloc] initWithSize:size];
    [newImage lockFocus];
    [self drawInRect:NSMakeRect(0, 0, size.width, size.height)];
    [newImage unlockFocus];
    return newImage;
}

- (NSImage *)resizedCellImage
{
    return [self resizedImage:NSMakeSize(50, 50)];
}

+ (NSImage *)cellImageNamed:(NSString *)name
{
    return [[NSImage imageNamed:name] resizedCellImage];
}

+ (NSImage *)deviceImageNamed:(NSString *)name
{
    return [[NSImage imageNamed:name] resizedImage:NSMakeSize(80, 80)];
}

@end
