//
//  WHTextMessageView.m
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHTextMessageView.h"
#import "WHMessage.h"

@interface WHMessageCellScrollView : NSScrollView

@end

@implementation WHMessageCellScrollView

- (void)scrollWheel:(NSEvent *)theEvent
{
    [self.enclosingScrollView scrollWheel:theEvent];
}

@end

@interface WHBaseMessageView ()

+ (instancetype)makeView;
@property (readwrite, nonatomic, strong) WHMessage *message;

@end

@implementation WHTextMessageView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)setupView
{
    [super setupView];
    [self.textView setString:[self.message message]];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.textView setBackgroundColor:[NSColor clearColor]];
}

+ (CGFloat)heightForMessage:(WHMessage *)message width:(CGFloat)width
{
    static WHTextMessageView *textMessageView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textMessageView = [self makeView];
    });
    textMessageView.message = message;
    [textMessageView setupView];
    
    NSRect rect = [textMessageView.textView.textStorage boundingRectWithSize:NSMakeSize(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin];
    
    return MAX(NSHeight(rect) + 10, [super heightForMessage:message width:width]);
}


@end
