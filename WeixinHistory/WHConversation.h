//
//  WHConversation.h
//  WeixinHistory
//
//  Created by XCC on 12/2/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHConversation : NSObject

+ (instancetype)conversationWithResult:(FMResultSet *)set;

@property (readonly) NSArray *messages;

@end
