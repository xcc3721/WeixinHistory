//
//  WHConversation.m
//  WeixinHistory
//
//  Created by XCC on 12/2/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHConversation.h"
#import "WHMessage.h"

@interface WHConversation ()

@property (nonatomic, readwrite, strong) NSArray *messages;

@end


@implementation WHConversation

+ (instancetype)conversationWithResult:(FMResultSet *)set
{
    NSMutableArray *array = [NSMutableArray array];
    while ([set next])
    {
        WHMessage *message = [[WHMessage alloc] initWithDictionary:set.resultDictionary];
        [array addObject:message];
    }
    
    WHConversation *conversation = [[self alloc] init];
    [conversation setMessages:[NSArray arrayWithArray:array]];
    
    return conversation;
}

@end
