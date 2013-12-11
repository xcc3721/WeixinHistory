//
//  PXColorPickerView.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


typedef struct {
    NSInteger x;
    NSInteger y;
} PXColorPickerLocation;


@class PXColorWellCell;


@interface PXColorPickerView : NSView {
@private
    NSTrackingArea *boundsTrackingArea;
    PXColorPickerLocation hoverLocation;
    BOOL hoverShowColors;
    PXColorWellCell *_colorWellCell;
    BOOL _allowsTransparent;
}

@property (retain) PXColorWellCell *colorWellCell;
@property BOOL allowsTransparent;

@end
