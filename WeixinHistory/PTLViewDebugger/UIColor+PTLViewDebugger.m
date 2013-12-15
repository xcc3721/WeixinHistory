//
//  UIColor+PTLViewDebugger.m
//  PTLViewDebugger
//
//  Created by Brian Partridge on 11/17/13.
//
//

#import "UIColor+PTLViewDebugger.h"

@implementation UIColor (PTLViewDebugger)

+ (UIColor *)ptl_randomColor {
    CGFloat r = (arc4random() % 256) / 255.0;
    CGFloat g = (arc4random() % 256) / 255.0;
    CGFloat b = (arc4random() % 256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

- (CGColorSpaceModel)ptl_colorSpace {
    CGColorSpaceRef colorSpace = CGColorGetColorSpace(self.CGColor);
    return CGColorSpaceGetModel(colorSpace);
}

- (CGFloat)ptl_red {
    CGFloat value = 0;
    CGColorSpaceModel colorSpace = [self ptl_colorSpace];
    if (colorSpace == kCGColorSpaceModelRGB) {
        [self getRed:&value green:NULL blue:NULL alpha:NULL];
    } else if (colorSpace == kCGColorSpaceModelMonochrome) {
        value = [self ptl_white];
    }
    return value;
}

- (CGFloat)ptl_green {
    CGFloat value = 0;
    CGColorSpaceModel colorSpace = [self ptl_colorSpace];
    if (colorSpace == kCGColorSpaceModelRGB) {
        [self getRed:NULL green:&value blue:NULL alpha:NULL];
    } else if (colorSpace == kCGColorSpaceModelMonochrome) {
        value = [self ptl_white];
    }
    return value;
}

- (CGFloat)ptl_blue {
    CGFloat value = 0;
    CGColorSpaceModel colorSpace = [self ptl_colorSpace];
    if (colorSpace == kCGColorSpaceModelRGB) {
        [self getRed:NULL green:NULL blue:&value alpha:NULL];
    } else if (colorSpace == kCGColorSpaceModelMonochrome) {
        value = [self ptl_white];
    }
    return value;
}

- (CGFloat)ptl_white {
    if ([self ptl_colorSpace] != kCGColorSpaceModelMonochrome) {
        return 0;
    }

    CGFloat value = 0;
    [self getWhite:&value alpha:NULL];
    return value;
}

- (CGFloat)ptl_alpha {
    CGFloat value = 0;
    CGColorSpaceModel colorSpace = [self ptl_colorSpace];
    if (colorSpace == kCGColorSpaceModelRGB) {
        [self getRed:NULL green:NULL blue:NULL alpha:&value];
    } else if (colorSpace == kCGColorSpaceModelMonochrome) {
        [self getWhite:NULL alpha:&value];
    }
    return value;
}

@end
