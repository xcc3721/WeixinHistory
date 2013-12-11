//
//  PXViewController.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2011 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/*!
 * @category NSViewController(PXViewController)
 * @abstract Additions to NSViewController
 * 
 * @discussion
 * Photon defines several major additions to NSViewController, enabling
 * it to be have similarly to the UIViewController class in Cocoa Touch.
 * 
 * Some of the enhancements:
 * - A hierarchy for view controllers (parent-child relationships)
 * - Notification methods for appearance and disappearance
 * - NSViewController is automatically made part of the responder chain (just above its view)
 */
@interface NSViewController (PXViewController)

/*!
 * @method px_installViewControllerSupport
 * @abstract Enables support for extended view controllers
 * 
 * @discussion
 * Calling this method is required in order for view controllers
 * to participate in the responder chain, in appearance notifications, etc.
 */
+ (void)px_installViewControllerSupport;


/*!
 * @method viewDidLoad
 * @abstract Invoked when the view controller's view hiearchy is loaded into memory
 */
- (void)viewDidLoad;

/*!
 * @method viewWillAppear:
 * @abstract Notifies the view controller that its view is about to be added to a view hierarchy
 * 
 * @param animated
 * Whether the transition is animated
 */
- (void)viewWillAppear:(BOOL)animated;

/*!
 * @method viewDidAppear:
 * @abstract Notifies the view controller that its view was added to a view hierarchy
 *
 * @param animated
 * Whether the transition is animated
 */
- (void)viewDidAppear:(BOOL)animated;

/*!
 * @method viewWillDisappear:
 * @abstract Notifies the view controller that its view is about to be removed from a view hierarchy
 *
 * @param animated
 * Whether the transition is animated
 */
- (void)viewWillDisappear:(BOOL)animated;

/*!
 * @method viewDidDisappear:
 * @abstract Notifies the view controller that its view was removed from a view hierarchy
 *
 * @param animated
 * Whether the transition is animated
 */
- (void)viewDidDisappear:(BOOL)animated;


/*!
 * @property parentViewController
 * @abstract The parent of the view controller
 *
 * @result An NSViewController object
 */
@property (nonatomic, weak, readonly) NSViewController *parentViewController;

/*!
 * @method addChildViewController:
 * @abstract Adds a given view controller as a child
 * 
 * @param childController
 * The child view controller
 * 
 * @discussion
 * This method is only intended to be invoked by a custom container view controller.
 * If you override this method, you must call the super implementation.
 */
- (void)addChildViewController:(NSViewController *)childController;

/*!
 * @method removeFromParentViewController
 * @abstract Removes the receiver from its parent in the view controller hierarchy.
 * 
 * @discussion
 * This method is only intended to be invoked by a custom container view controller.
 * If you override this method, you must call the super implementation.
 */
- (void)removeFromParentViewController;

/*!
 * @method willMoveToParentViewController:
 * @abstract Called just before the view controller is added or removed from a container view controller
 * 
 * @param parent
 * The parent view controller, or nil
 * 
 * @discussion
 * If you are implementing your own container view controller, it must call
 * the willMoveToParentViewController: method of the child view controller before
 * calling the removeFromParentViewController method, passing in a parent value of nil.
 * 
 * When your custom container calls the addChildViewController: method, it
 * automatically calls the willMoveToParentViewController: method of the view
 * controller to be added as a child before adding it.
 */
- (void)willMoveToParentViewController:(NSViewController *)parent;

/*!
 * @method didMoveToParentViewController:
 * @abstract Called after the view controller is added or removed from a container view controller
 *
 * @param parent
 * The parent view controller, or nil
 *
 * @discussion
 * If you are implementing your own container view controller, it must call
 * the didMoveToParentViewController: method of the child view controller before
 * calling the removeFromParentViewController method, passing in a parent value of nil.
 *
 * When your custom container calls the addChildViewController: method, it
 * automatically calls the didMoveToParentViewController: method of the view
 * controller to be added as a child before adding it.
 */
- (void)didMoveToParentViewController:(NSViewController *)parent;

@end


@interface NSWindow (PXViewController)

@property (nonatomic, strong) NSViewController *rootViewController;

@end
