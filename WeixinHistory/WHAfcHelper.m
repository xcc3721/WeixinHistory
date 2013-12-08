//
//  WHAfcHelper.m
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHAfcHelper.h"

@implementation WHAfcHelper

+ (NSArray *)contentsOfDirectory:(NSString *)directoryPath afc:(afc_client_t)afc
{
    char **list = nil;
    NSInteger ret = afc_read_directory(afc, [directoryPath UTF8String], &list);
    NSMutableArray *array = [NSMutableArray array];
    if(ret == AFC_E_SUCCESS)
    {
        NSLog(@"Read [%@] succeeded!", directoryPath);
        NSInteger i = 0;
        while (list[i] != nil)
        {
            NSString *item = [NSString stringWithCString:list[i++] encoding:NSUTF8StringEncoding];
            [array addObject:item];
        }
        return [NSArray arrayWithArray:array];
    }
    else
    {
        NSLog(@"Read [%@] failed, error code:%ld", directoryPath, ret);
        return nil;
    }
}

@end
