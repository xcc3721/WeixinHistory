//
//  PXBarButtonItem.h
//  Photon
//
//  Created by Logan Collins on 9/7/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PXBarButtonItem : NSObject

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (id)initWithImage:(NSImage *)image target:(id)target action:(SEL)action;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSImage *image;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL action;

@end
