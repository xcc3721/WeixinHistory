//
//  WHVoiceMessageView.h
//  WeixinHistory
//
//  Created by XCC on 12/15/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHBaseMessageView.h"

@protocol WHVoiceMessageViewDelegate <WHMessageViewDelegate>

- (void)playVoiceForMessage:(WHMessage *)message;

@end

@interface WHVoiceMessageView : WHBaseMessageView

@property (nonatomic, weak) id<WHVoiceMessageViewDelegate> delegate;

@end
