//
//  PXTabBarItem.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2011 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PXTabBarItem : NSObject

@property (copy) NSString *title;
@property (copy) NSImage *image;
@property (weak) id representedObject;
@property (copy) NSString *badgeValue;
@property NSUInteger tag;
@property (copy) NSString *toolTip;

@end
