//
//  WHTextMessageCellView.m
//  WeixinHistory
//
//  Created by XCC on 12/12/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHTextMessageCellView.h"
@interface WHTextMessageCellView ()


@property (weak) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak) IBOutlet NSLayoutConstraint *rightConstraint;

@property (weak) IBOutlet PXLabel *textLabel;

@end


@implementation WHTextMessageCellView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

- (void)setupWithMessage:(WHMessage *)message
{
    if (message.dest == MessageReceived)
    {
        [self.leftConstraint setConstant:0];
        [self.rightConstraint setConstant:100];
        [self.textLabel setTextAlignment:NSLeftTextAlignment];
    }
    else
    {
        [self.leftConstraint setConstant:100];
        [self.rightConstraint setConstant:0];
        [self.textLabel setTextAlignment:NSLeftTextAlignment];
    }
    [self.textLabel setText:message.message];
}



@end
