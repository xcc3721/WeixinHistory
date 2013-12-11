//
//  PXPopover_Private.h
//  Photon
//
//  Created by Logan Collins on 2/27/13.
//  Copyright (c) 2013 Sunflower Softworks. All rights reserved.
//

#import "PXPopover.h"
#import "PXViewController_Private.h"


@interface PXPopover ()

@property (nonatomic, readwrite, getter=isShown) BOOL shown;
@property (nonatomic, readwrite) PXPopoverArrowDirection arrowDirection;

- (PXPopoverBackgroundView *)backgroundView;
- (NSView *)positioningView;
- (NSWindow *)window;

@end


@interface PXPopoverWindow : NSPanel

@end


@interface PXPopoverBackgroundView ()

@property (nonatomic, weak) PXPopover *popover;

@end


@interface PXConcretePopoverBackgroundView : PXPopoverBackgroundView

@end


@interface NSViewController (PXPopover)

- (PXPopover *)px_popover;
- (void)px_setPopover:(PXPopover *)popover;

@end


@interface NSWindow (PXPopover)

- (BOOL)px_hasKeyAppearance;

- (PXPopover *)px_presentedPopover;
- (void)px_setPresentedPopover:(PXPopover *)popover;

@end
