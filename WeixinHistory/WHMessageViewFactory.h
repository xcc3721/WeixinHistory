//
//  WHMessageViewFactory.h
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHMessageViewProtocol.h"
@class WHMessage;

@interface WHMessageViewFactory : NSObject

+ (id<WHMessageViewProtocol>)messageViewWithMessage:(WHMessage *)message;
+ (Class<WHMessageViewProtocol>)messageViewClassForMessage:(WHMessage *)message;

@end
