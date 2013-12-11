//
//  PXPopover.h
//  Photon
//
//  Created by Logan Collins on 2/27/13.
//  Copyright (c) 2013 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Photon/PhotonDefines.h>
#import <Photon/PXGeometry.h>


typedef NS_OPTIONS(NSUInteger, PXPopoverArrowDirection) {
    PXPopoverArrowDirectionUp = (1 << 0),
    PXPopoverArrowDirectionDown = (1 << 1),
    PXPopoverArrowDirectionLeft = (1 << 2),
    PXPopoverArrowDirectionRight = (1 << 3),
    PXPopoverArrowDirectionAny = (PXPopoverArrowDirectionUp | PXPopoverArrowDirectionDown | PXPopoverArrowDirectionLeft | PXPopoverArrowDirectionRight),
    PXPopoverArrowDirectionUnknown = NSIntegerMax,
};


@protocol PXPopoverDelegate;


@interface PXPopover : NSResponder

- (id)initWithContentViewController:(NSViewController *)viewController;

@property (nonatomic, strong) NSViewController *contentViewController;
- (void)setContentViewController:(NSViewController *)contentViewController animated:(BOOL)animated;

@property (nonatomic) NSSize contentSize;
- (void)setContentSize:(NSSize)contentSize animated:(BOOL)animated;

@property (nonatomic, weak) id <PXPopoverDelegate> delegate;

- (void)showRelativeToRect:(NSRect)rect ofView:(NSView *)view permittedArrowDirections:(PXPopoverArrowDirection)arrowDirection animated:(BOOL)animated;
- (void)makeKeyAndShowRelativeToRect:(NSRect)rect ofView:(NSView *)view permittedArrowDirections:(PXPopoverArrowDirection)arrowDirection animated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;

@property (nonatomic, readonly, getter=isShown) BOOL shown;
@property (nonatomic, readonly) PXPopoverArrowDirection arrowDirection;

@property (nonatomic, assign) Class backgroundViewClass;

@end


@protocol PXPopoverDelegate <NSObject>

@optional
- (void)popoverDidDismiss:(PXPopover *)popover;

@end


@interface PXPopoverBackgroundView : NSView

+ (PXEdgeInsets)contentViewInsets;

+ (CGFloat)arrowHeight;
+ (CGFloat)arrowBase;

@property (nonatomic, readwrite) CGFloat arrowOffset;
@property (nonatomic, readwrite) PXPopoverArrowDirection arrowDirection;

@end


PHOTON_EXTERN NSString * const PXPopoverWillShowNotification;
PHOTON_EXTERN NSString * const PXPopoverDidShowNotification;

PHOTON_EXTERN NSString * const PXPopoverWillDismissNotification;
PHOTON_EXTERN NSString * const PXPopoverDidDismissNotification;
