//
//  PXColorWell.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/* PXColorWell is a color control with a drop-down view for
 * choosing a color, similar to controls in iWork apps
 */
@interface PXColorWell : NSControl

@property (copy) NSColor *color;
@property (strong) PXColorWell *textColorWell;
@property BOOL allowsTransparent;

@end


@interface PXColorWellCell : NSActionCell

@property (copy) NSColor *color;
@property (strong) PXColorWell *textColorWell;
@property BOOL allowsTransparent;

@end
