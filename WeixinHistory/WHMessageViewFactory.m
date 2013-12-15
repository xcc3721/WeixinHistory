//
//  WHMessageViewFactory.m
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHMessageViewFactory.h"
#import "WHTextMessageView.h"
#import "WHUnknownMessageView.h"
#import "WHVoiceMessageView.h"


#import "WHMessage.h"

@implementation WHMessageViewFactory

+ (id<WHMessageViewProtocol>)messageViewWithMessage:(WHMessage *)message
{
//    switch (message.type) {
//        case MessageTypeText:
//        {
//            return [WHTextMessageView viewWithMessage:message];
//        }
//            break;
//            //        case MessageTypeAppShare:
//            //        {
//            //
//            //        }
//            //            break;
//            //        case MessageTypeSystem:
//            //        {
//            //
//            //        }
//            //            break;
//        case MessageTypeVoice:
//        {
//            return [WHVoiceMessageView viewWithMessage:message];
//        }
//            //            break;
//            
//        default:
//            return [WHUnknownMessageView viewWithMessage:message];
//            break;
//    }
//    return nil;
    return [[self messageViewClassForMessage:message] viewWithMessage:message];
}

+ (Class<WHMessageViewProtocol>)messageViewClassForMessage:(WHMessage *)message
{
    switch (message.type) {
        case MessageTypeText:
        {
            return [WHTextMessageView class];
        }
            break;
            //        case MessageTypeAppShare:
            //        {
            //
            //        }
            //            break;
            //        case MessageTypeSystem:
            //        {
            //
            //        }
            //            break;
        case MessageTypeVoice:
        {
            return [WHVoiceMessageView class];
        }
            break;
            
        default:
            return [WHUnknownMessageView class];
            break;
    }
    return nil;
}

@end
