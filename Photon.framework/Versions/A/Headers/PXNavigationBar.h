//
//  PXNavigationBar.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2011 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Photon/PhotonDefines.h>
#import <Photon/PXAppearance.h>


typedef NS_ENUM(NSUInteger, PXNavigationBarStyle) {
    PXNavigationBarStyleLight = 0,
    PXNavigationBarStyleDark,
};


@class PXNavigationItem;
@protocol PXNavigationBarDelegate;


@interface PXNavigationBar : NSView

@property (nonatomic, weak) id <PXNavigationBarDelegate> delegate;

@property (nonatomic) PXNavigationBarStyle style;

@property (nonatomic, copy) NSArray *items;
- (void)setItems:(NSArray *)items animated:(BOOL)isAnimated;

@property (nonatomic, strong, readonly) PXNavigationItem *topItem;
@property (nonatomic, strong, readonly) PXNavigationItem *backItem;

- (void)pushNavigationItem:(PXNavigationItem *)item animated:(BOOL)isAnimated;
- (void)popToNavigationItem:(PXNavigationItem *)item animated:(BOOL)isAnimated;
- (void)popToRootNavigationItemAnimated:(BOOL)isAnimated;
- (void)popNavigationItemAnimated:(BOOL)isAnimated;

@end


@protocol PXNavigationBarDelegate <NSObject>

@optional

- (BOOL)navigationBar:(PXNavigationBar *)navigationBar shouldPushItem:(PXNavigationItem *)item;
- (void)navigationBar:(PXNavigationBar *)navigationBar didPushItem:(PXNavigationItem *)item;

- (BOOL)navigationBar:(PXNavigationBar *)navigationBar shouldPopItem:(PXNavigationItem *)item;
- (void)navigationBar:(PXNavigationBar *)navigationBar didPopItem:(PXNavigationItem *)item;

@end
