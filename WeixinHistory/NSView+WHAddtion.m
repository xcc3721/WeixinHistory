//
//  NSView+WHAddtion.m
//  WeixinHistory
//
//  Created by XCC on 12/10/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "NSView+WHAddtion.h"

@implementation NSView (WHAddtion)

- (void)bindSameSizeWithSubview:(NSView *)subview
{
    if (![[self subviews] containsObject:subview]) {
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[subview]-0-|" options:NSLayoutAttributeLeading metrics:nil views:NSDictionaryOfVariableBindings(subview)]];
    [array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[subview]-0-|" options:NSLayoutAttributeTop metrics:nil views:NSDictionaryOfVariableBindings(subview)]];
    [self addConstraints:array];
}

- (NSPoint)center
{
    return NSMakePoint(NSMaxX(self.frame) / 2, NSMaxX(self.frame) / 2);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", [super description], NSStringFromRect(self.frame)];
}

@end
