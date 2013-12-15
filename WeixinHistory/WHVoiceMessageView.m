//
//  WHVoiceMessageView.m
//  WeixinHistory
//
//  Created by XCC on 12/15/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHVoiceMessageView.h"
#import "WHMessage.h"

@implementation WHVoiceMessageView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (IBAction)playVoice:(id)sender
{
    NSLog(@"%@", self.message.message);
    [self.delegate playVoiceForMessage:self.message];
}

@end
