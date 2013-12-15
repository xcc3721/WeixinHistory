//
//  UIView+PTLViewDebugger.m
//  PTLViewDebugger
//
//  Created by Brian Partridge on 11/17/13.
//
//

#import "UIView+PTLViewDebugger.h"
#import "UIColor+PTLViewDebugger.h"
#import "NSObject+PTLSwizzle.h"
#import <objc/runtime.h>

static NSString * const kPTLColorEscapeSequence = @"\033[";
static NSString * const kPTLViewDebuggerEnabled = @"com.peartreelabs.viewdebugger.PTLViewDebuggerEnabled";
static NSString * const kPTLViewDebuggerPreviousBorderColor = @"com.peartreelabs.viewdebugger.PTLViewDebuggerPreviousBorderColor";
static NSString * const kPTLViewDebuggerPreviousBorderWidth = @"com.peartreelabs.viewdebugger.PTLViewDebuggerPreviousBorderWidth";

@implementation UIView (PTLViewDebugger)

+ (void)load {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [UIView ptl_swizzleMethod:@selector(recursiveDescription) withMethod:@selector(ptl_recursiveDescription)];
#pragma clang diagnostic pop
}

#pragma mark - Debug Border

- (CGFloat)ptl_minLineWidth {
    return (self.window.screen.backingScaleFactor == 0.0) ? 1.0 : 1.0 / (self.window.screen.backingScaleFactor);
}

- (void)ptl_showDebugBorder {
    [self ptl_showDebugBorder:NO];
}

- (void)ptl_showDebugBorder:(BOOL)trickleDown {
    if ([objc_getAssociatedObject(self, (__bridge const void *)(kPTLViewDebuggerEnabled)) boolValue]) {
        return;
    }

    objc_setAssociatedObject(self, (__bridge const void *)(kPTLViewDebuggerEnabled), @YES, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, (__bridge const void *)(kPTLViewDebuggerPreviousBorderColor), [UIColor colorWithCGColor:self.layer.borderColor], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, (__bridge const void *)(kPTLViewDebuggerPreviousBorderWidth), @(self.layer.borderWidth), OBJC_ASSOCIATION_RETAIN);

    self.layer.borderColor = [UIColor ptl_randomColor].CGColor;

    CGFloat width = [self ptl_minLineWidth];
    // Adjust the border width so that it isn't hidden by the superview's border on any edge.
    CGFloat superviewBorderWidth = self.superview.layer.borderWidth;
    if (self.frame.origin.x < superviewBorderWidth ||
        self.frame.origin.y < superviewBorderWidth ||
        CGRectGetMaxX(self.frame) + superviewBorderWidth >= self.superview.frame.size.width ||
        CGRectGetMaxY(self.frame) + superviewBorderWidth >= self.superview.frame.size.width) {
        width += superviewBorderWidth;
    }
    // Adjust the border with to not cover the entire view content.
    CGFloat minDimension = MIN(self.frame.size.width, self.frame.size.height);
    if (minDimension < 2 * width) {
        width = minDimension / 2.0;
    }
    self.layer.borderWidth = width;

    if (trickleDown) {
        for (UIView *subview in self.subviews) {
            [subview ptl_showDebugBorder:trickleDown];
        }
    }
}

- (void)ptl_hideDebugBorder {
    [self ptl_hideDebugBorder:NO];
}

- (void)ptl_hideDebugBorder:(BOOL)trickleDown {
    if (![objc_getAssociatedObject(self, (__bridge const void *)(kPTLViewDebuggerEnabled)) boolValue]) {
        return;
    }

    objc_setAssociatedObject(self, (__bridge const void *)(kPTLViewDebuggerEnabled), @NO, OBJC_ASSOCIATION_RETAIN);
    self.layer.borderColor = ((UIColor *)objc_getAssociatedObject(self, (__bridge const void *)(kPTLViewDebuggerPreviousBorderColor))).CGColor;
    self.layer.borderWidth = [objc_getAssociatedObject(self, (__bridge const void *)(kPTLViewDebuggerPreviousBorderWidth)) floatValue];

    if (trickleDown) {
        for (UIView *view in self.subviews) {
            [view ptl_hideDebugBorder:trickleDown];
        }
    }
}

#pragma mark - Styled Description

- (NSString *)ptl_description {
    if ([objc_getAssociatedObject(self, (__bridge const void *)(kPTLViewDebuggerEnabled)) boolValue]) {
        UIColor *color = [UIColor colorWithCGColor:self.layer.borderColor];
        return [NSString stringWithFormat:@"%@fg%0.0f,%0.0f,%0.0f;%@%@fg;",
                kPTLColorEscapeSequence,
                [color ptl_red] * 255.0,
                [color ptl_green] * 255.0,
                [color ptl_blue] * 255.0,
                self.description,
                kPTLColorEscapeSequence];
    }
    return self.description;
}

- (NSString *)ptl_recursiveDescription {
    return [self ptl_recursiveDescription:0];
}

- (NSString *)ptl_recursiveDescription:(NSUInteger)level {
    NSString *padding = @"   | ";
    NSMutableString *result = [[@"" stringByPaddingToLength:padding.length * level
                                                 withString:padding
                                            startingAtIndex:0] mutableCopy];
    [result appendString:[self ptl_description]];

    for (UIView *subview in self.subviews) {
        NSString *description = [subview ptl_recursiveDescription:level + 1];
        if (description) {
            [result appendFormat:@"\n%@", description];
        }
    }

    return [result copy];
}

@end
