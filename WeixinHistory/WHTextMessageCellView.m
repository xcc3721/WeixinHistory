//
//  WHTextMessageCellView.m
//  WeixinHistory
//
//  Created by XCC on 12/12/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHTextMessageCellView.h"
@interface WHTextMessageCellView ()

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
    [self.textLabel setText:message.message];
}



@end
