//
//  PXLabel.h
//  Photon
//
//  Created by Logan Collins on 3/5/13.
//  Copyright (c) 2013 Sunflower Softworks. All rights reserved.
//

#import <Photon/PXView.h>


@interface PXLabel : PXView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSFont *font;
@property (nonatomic, strong) NSColor *textColor;
@property (nonatomic, strong) NSColor *shadowColor;
@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) NSTextAlignment textAlignment;
@property (nonatomic) NSLineBreakMode lineBreakMode;

@property (nonatomic, strong) NSColor *highlightedTextColor;
@property (nonatomic, strong) NSColor *highlightedBackgroundColor;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

- (CGSize)sizeThatFits:(CGSize)size;
- (void)sizeToFit;

- (void)drawTextInRect:(CGRect)rect;

@end
