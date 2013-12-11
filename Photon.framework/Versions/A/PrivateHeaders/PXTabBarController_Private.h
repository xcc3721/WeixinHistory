//
//  PXTabBarController_Private.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Photon/PXTabBarController.h>


@interface PXTabBarController () <NSAnimationDelegate>

- (void)addViewController:(NSViewController *)viewController;
- (void)insertViewController:(NSViewController *)viewController atIndex:(NSUInteger)index;
- (void)removeViewController:(NSViewController *)viewController;
- (void)removeViewControllerAtIndex:(NSUInteger)index;
- (NSViewController *)viewControllerAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfViewController:(NSViewController *)viewController;

- (void)selectViewController:(NSViewController *)viewController;
- (void)selectViewControllerAtIndex:(NSUInteger)index;

- (void)replaceView:(NSView *)oldView withView:(NSView *)newView push:(BOOL)shouldPush animated:(BOOL)isAnimated;

@end
