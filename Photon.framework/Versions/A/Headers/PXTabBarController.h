//
//  PXTabBarController.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2011 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Photon/PhotonDefines.h>
#import <Photon/PXViewController.h>
#import <Photon/PXTabBar.h>


@class PXTabBar;
@protocol PXTabBarControllerDelegate, PXTabBarDelegate;


/*!
 * @class PXTabBarController
 * @abstract Coordinates a tabbed set of view controllers
 */
@interface PXTabBarController : NSViewController <PXTabBarDelegate>

@property (nonatomic, readonly) PXTabBar *tabBar;

@property (nonatomic, weak) id <PXTabBarControllerDelegate> delegate;

@property (nonatomic) NSArray *viewControllers;

@property (nonatomic, strong) NSViewController *selectedViewController;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic) BOOL animatesViewTransition;

@end


@protocol PXTabBarControllerDelegate <NSObject>

@optional

- (BOOL)tabBarController:(PXTabBarController *)aTabBarController shouldSelectViewController:(NSViewController *)viewController;
- (void)tabBarController:(PXTabBarController *)aTabBarController willSelectViewController:(NSViewController *)viewController;
- (void)tabBarController:(PXTabBarController *)aTabBarController didSelectViewController:(NSViewController *)viewController;

@end


@interface NSViewController (PXTabBarController)

/*!
 * @property tabBarController
 * @abstract Gets the tab bar controller containing the receiver
 *
 * @result A PXTabBarController object
 */
@property (strong, readonly) PXTabBarController *tabBarController;

/*!
 * @property tabBarItem
 * @abstract Gets the tab bar item representing the receiver
 *
 * @result A PXTabBarItem object
 */
@property (strong, readonly) PXTabBarItem *tabBarItem;

@end
