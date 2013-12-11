//
//  PXViewController_Private.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2011 Sunflower Softworks. All rights reserved.
//

#import "PXViewController.h"


@interface PXViewControllerProxy : NSObject

@property (nonatomic, weak) id object;

@end


@interface NSViewController (PXViewControllerPrivate)

- (void)px_setView:(NSView *)aView;

@property (nonatomic, weak, readwrite) NSViewController *parentViewController;

@end


@interface NSView (PXViewController)

+ (void)px_installViewControllerSupport;

- (NSViewController *)px_viewController;
- (void)px_setViewController:(NSViewController *)viewController;

- (void)px_setNextResponder:(NSResponder *)responder;

@end


@interface NSPopover (PXViewController)

+ (void)px_installViewControllerSupport;

- (void)px_setContentViewController:(NSViewController *)viewController;

@end
