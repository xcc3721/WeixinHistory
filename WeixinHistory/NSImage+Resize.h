//
//  NSImage+Resize.h
//  WeixinHistory
//
//  Created by XCC on 12/7/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Resize)

- (NSImage *)resizedImage:(NSSize)size;
- (NSImage *)resizedCellImage;

+ (NSImage *)cellImageNamed:(NSString *)name;
+ (NSImage *)deviceImageNamed:(NSString *)name;

@end
