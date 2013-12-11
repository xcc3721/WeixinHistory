//
//  PXSwitch.h
//  Photon
//
//  Created by Logan Collins on 3/25/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PXSwitch : NSControl

@property (getter=isEnabled) BOOL enabled;

@property (getter=isOn) BOOL on;
- (void)setOn:(BOOL)on animated:(BOOL)animated;

@property NSColor *onTintColor;

@end
