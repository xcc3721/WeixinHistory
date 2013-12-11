//
//  NSColor+PhotonAdditions.h
//  Photon
//
//  Created by Logan Collins on 8/2/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSColor (PhotonAdditions)

+ (NSColor *)px_colorWithCGColor:(CGColorRef)cgColor;

@property (readonly) CGColorRef px_CGColor;

@end
