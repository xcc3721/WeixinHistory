//
//  WHBaseMessageView.h
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHMessageViewProtocol.h"

@interface WHBaseMessageView : NSView <WHMessageViewProtocol>

@property (readonly, nonatomic) WHMessage *message;
@property (weak, nonatomic) id<WHMessageViewDelegate> delegate;

@end
