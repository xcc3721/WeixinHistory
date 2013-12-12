//
//  WHTextMessageCellView.m
//  WeixinHistory
//
//  Created by XCC on 12/12/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHTextMessageCellView.h"
@interface WHTextMessageCellView ()

<<<<<<< HEAD
@property (weak) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak) IBOutlet NSLayoutConstraint *rightConstraint;
=======
>>>>>>> 1f782499d2601392684bcc6ec64e252ef27507e9
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
        [self.rightConstraint setConstant:20];
        [self.textLabel setTextAlignment:NSLeftTextAlignment];
    }
    else
    {
        [self.leftConstraint setConstant:20];
        [self.rightConstraint setConstant:0];
        [self.textLabel setTextAlignment:NSRightTextAlignment];
        
    }
}



@end
