//
//  WHMessageViewFactory.m
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHMessageViewFactory.h"
#import "WHTextMessageView.h"
#import "WHMessage.h"

@implementation WHMessageViewFactory

+ (id<WHMessageViewProtocol>)messageViewWithMessage:(WHMessage *)message
{
    switch (message.type) {
        case MessageTypeText:
        {
            return [[WHTextMessageView alloc] initWithMessage:message];
        }
            break;
        case MessageTypeAppShare:
        {
            
        }
            break;
        case MessageTypeSystem:
        {
            
        }
            break;
        case MessageTypeVoice:
        {
            
        }
            break;
            
        default:
            break;
    }
    return nil;
}

+ (Class)messageViewClassForMessage:(WHMessage *)message
{
    switch (message.type) {
        case MessageTypeText:
        {
            return [WHTextMessageView class];
        }
            break;
        case MessageTypeAppShare:
        {
            
        }
            break;
        case MessageTypeSystem:
        {
            
        }
            break;
        case MessageTypeVoice:
        {
            
        }
            break;
            
        default:
            break;
    }
    return nil;
}

@end
