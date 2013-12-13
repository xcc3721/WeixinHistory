//
//  WHMessageCellView.m
//  WeixinHistory
//
//  Created by XCC on 12/12/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHMessageCellView.h"
#import "WHMessageViewFactory.h"
#import "WHBaseMessageView.h"

@implementation WHMessageCellView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}


- (void)setupWithMessage:(WHMessage *)message
{
    WHBaseMessageView *messageView = (WHBaseMessageView *)[WHMessageViewFactory messageViewWithMessage:message];
    [self.containerView addSubview:messageView];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.containerView bindSameSizeWithSubview:messageView];
}

- (void)prepareForReuse
{
    [[self.containerView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
