//
//  PXTabBar_Private.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Photon/PXTabBar.h>


@interface PXTabBar ()

- (void)update;
- (void)setSelectedItem:(PXTabBarItem *)item;
- (PXTabBarItem *)itemAtPoint:(NSPoint)thePoint;
- (NSRect)itemsRect;
- (CGFloat)widthOfItem:(PXTabBarItem *)item;

- (void)addItem:(PXTabBarItem *)item;
- (void)insertItem:(PXTabBarItem *)item atIndex:(NSUInteger)index;
- (void)removeItem:(PXTabBarItem *)item;
- (void)removeItemAtIndex:(NSUInteger)index;
- (PXTabBarItem *)itemAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfItem:(PXTabBarItem *)item;

- (void)selectItem:(PXTabBarItem *)item;
- (void)selectItemAtIndex:(NSUInteger)index;

@end
