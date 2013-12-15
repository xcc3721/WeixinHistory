//
//  UIColor+PTLViewDebugger.h
//  PTLViewDebugger
//
//  Created by Brian Partridge on 11/17/13.
//
//


@interface UIColor (PTLViewDebugger)

/**
 * @return A randomly generated RGB color.
 */
+ (UIColor *)ptl_randomColor;

/**
 * @return The color space of the color.
 */
- (CGColorSpaceModel)ptl_colorSpace;

/**
 * @return The red component of an RGB or monochrome color.
 */
- (CGFloat)ptl_red;

/**
 * @return The green component of an RGB or monochrome color.
 */
- (CGFloat)ptl_green;

/**
 * @return The blue component of an RGB or monochrome color.
 */
- (CGFloat)ptl_blue;

/**
 * @return The alpha component of an RGB or monochrome color.
 */
- (CGFloat)ptl_alpha;

/**
 * @return The white component of a monochrome color.
 */
- (CGFloat)ptl_white;

@end
