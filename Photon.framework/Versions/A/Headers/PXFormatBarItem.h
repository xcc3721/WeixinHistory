//
//  PXFormatBarItem.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PXFormatBarItem : NSObject

- (id)initWithIdentifier:(NSString *)anIdentifier;

@property (copy, readonly) NSString *identifier;

@property (copy) NSString *label;
@property (copy) NSImage *image;

@property (strong) NSView *view;

@end
