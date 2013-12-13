//
//  WHMessageCellView.h
//  WeixinHistory
//
//  Created by XCC on 12/12/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHMessage.h"

@interface WHMessageCellView : NSTableCellView

- (void)setupWithMessage:(WHMessage *)message;

@property (weak) IBOutlet NSImageView *avatarImageView;
@property (weak) IBOutlet NSView *containerView;


@end
