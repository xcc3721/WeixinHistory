//
//  PXFormatBar.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


extern NSString * const PXFormatBarSeparatorItemIdentifier;
extern NSString * const PXFormatBarFlexibleSpaceItemIdentifier;


@class PXFormatBarItem;
@protocol PXFormatBarDelegate;


@interface PXFormatBar : NSView

@property IBOutlet id <PXFormatBarDelegate> delegate;

@property (copy, readonly) NSArray *items;
@property (copy, readonly) NSArray *visibleItems;

- (void)reloadItems;

@end


@protocol PXFormatBarDelegate <NSObject>

@required
- (PXFormatBarItem *)formatBar:(PXFormatBar *)formatBar itemForItemIdentifier:(NSString *)itemIdentifier;
- (NSArray *)formatBarDefaultItemIdentifiers:(PXFormatBar *)formatBar;

@end
