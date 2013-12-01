//
//  WHConversation.m
//  WeixinHistory
//
//  Created by XCC on 12/2/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHConversation.h"
#import "WHMessage.h"

@implementation WHConversation

+ (instancetype)conversationWithResult:(FMResultSet *)set
{
    do {
        BOOL rc = [set next];
        if (rc)
        {
            
            NSLog(@"%@", [set resultDictionary]);
        }
    } while ([set hasAnotherRow]);
    
    return nil;
}

@end
