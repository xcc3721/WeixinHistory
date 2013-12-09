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
            if ([item isEqualToString:@"."] || [item isEqualToString:@".."])
            {
                continue;
            }
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

+ (NSDictionary *)fileInfo:(NSString *)path afc:(afc_client_t)afc
{
    char **infolist = nil;
    NSInteger ret = afc_get_file_info(afc, [path UTF8String], &infolist);
    if(ret == AFC_E_SUCCESS)
    {
        return [NSDictionary dictionaryFromCharArray:infolist];
    }
    else
    {
        NSLog(@"Read fileinfo at [%@] failed, error code:%ld", path, ret);
        return nil;
    }
    
}

+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDir afc:(afc_client_t)afc
{
    NSDictionary *dict = [self fileInfo:path afc:afc];
    if (dict == nil)
    {
        if (isDir)
        {
            *isDir = NO;
        }
        return NO;
    }
    else
    {
        if (isDir)
        {
            if ([dict[@"st_ifmt"] isEqualToString:@"S_IFDIR"])
            {
                *isDir = YES;
            }
            else
            {
                *isDir = NO;
            }
        }
        return YES;
    }
}

@end
