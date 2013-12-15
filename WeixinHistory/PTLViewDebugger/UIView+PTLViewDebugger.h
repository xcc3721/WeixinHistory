//
//  UIView+PTLViewDebugger.h
//  PTLViewDebugger
//
//  Created by Brian Partridge on 11/17/13.
//
//


@interface UIView (PTLViewDebugger)

/**
 * @return The minimum width of a line in the view's coordinate system on the current screen.
 */
- (CGFloat)ptl_minLineWidth;

/**
 * Adds a randomly colored border to the view.
 */
- (void)ptl_showDebugBorder;

/**
 * Adds a randomly colored border to the view and all subviews.
 */
- (void)ptl_showDebugBorder:(BOOL)trickleDown;

/**
 * Removes any previously set border on the view.
 */
- (void)ptl_hideDebugBorder;

/**
 * Removes any previously set border on the view and all subviews.
 */
- (void)ptl_hideDebugBorder:(BOOL)trickleDown;

/**
 * @return The default description for the view, styled with the currently shown debug border color.
 */
- (NSString *)ptl_description;

/**
 * @return The a string outlining the view hierarchy below of this view using ptl_description.
 */
- (NSString *)ptl_recursiveDescription;

@end
