//
//  WHApp.m
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHApp.h"
#import "NSDictionary+WHHelper.h"
#import "NSString+WHHelper.h"
#import "afc.h"
#import "WHAfcHelper.h"


@interface WHApp ()
{
    afc_client_t afc;
}

@end


@implementation WHApp

- (id)initWithHouseArrest:(house_arrest_client_t)house appid:(NSString *)appid
{
    if (house == nil || [appid length] == 0)
    {
        NSLog(@"Parameters not acceptable");
        return nil;
    }
    
    house_arrest_send_command(house, "VendDocuments", [appid UTF8String]);
    plist_t dict = nil;
    house_arrest_get_result(house, &dict);
    NSDictionary *result = [NSDictionary dictionaryFromPlist:dict];
    if (![result[@"Status"] isEqualToString:@"Complete"])
    {
        NSLog(@"get result error");
        return nil;
    }
    NSInteger ret = afc_client_new_from_house_arrest_client(house, &afc);
    if (ret != AFC_E_SUCCESS) {
        NSLog(@"AFC From HouseArrest Error:%ld", ret);
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (NSArray *)appContents
{
    return [WHAfcHelper contentsOfDirectory:@"/" afc:afc];
}

- (NSDictionary *)infoForFilePath:(NSString *)path
{
    return [WHAfcHelper fileInfo:path afc:afc];
}

- (NSArray *)contentsForDirectoryPath:(NSString *)path
{
    return [WHAfcHelper contentsOfDirectory:path afc:afc];
}

- (BOOL)copyfileAtPath:(NSString *)path completion:(void (^)(NSString *))completion
{
    BOOL isDir = NO;
    BOOL exist = [WHAfcHelper fileExistsAtPath:path isDirectory:&isDir afc:afc];
     NSString *destPath = [NSTemporaryDirectory() stringByAppendingString:[path lastPathComponent]];
    if (exist && isDir)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:destPath isDirectory:&isDir] && isDir)
        {
            [[NSFileManager defaultManager] removeItemAtPath:destPath error:nil];
        }
        [[NSFileManager defaultManager] createDirectoryAtPath:destPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [self copyfileAtPath:path destPath:destPath completion:completion];
}

- (BOOL)copyfileAtPath:(NSString *)path destPath:(NSString *)destPath completion:(void (^)(NSString *))completion
{
    BOOL isDir = NO;
    BOOL exist = [WHAfcHelper fileExistsAtPath:path isDirectory:&isDir afc:afc];
    if (exist == NO)
    {
        return NO;
    }
    if (isDir == NO)
    {
        uint64_t handle = 0;
        NSInteger ret = afc_file_open(afc, [path UTF8String], AFC_FOPEN_RDONLY, &handle);
        
        if(ret == AFC_E_SUCCESS)
        {
            NSDictionary *dict = [WHAfcHelper fileInfo:path afc:afc];
            size_t size = [dict[@"st_size"] longLongValue];
            char *buffer = malloc(size);
            uint32_t bytsRead = 0;
            afc_file_read(afc, handle, buffer, (int)size, &bytsRead);
            afc_file_close(afc, handle);
            NSData *data = [[NSData alloc] initWithBytesNoCopy:buffer length:size freeWhenDone:YES];
            BOOL result = [data writeToFile:destPath atomically:YES];
            if (completion) {
                completion(destPath);
            }
            
            return result;
        }
        else
        {
            NSLog(@"Open [%@] failed, error code:%ld", path, ret);
            return NO;
        }
        return YES;
    }
    else
    {
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:destPath isDirectory:&isDir] && isDir)
        {
            [[NSFileManager defaultManager] removeItemAtPath:destPath error:nil];
        }
        [[NSFileManager defaultManager] createDirectoryAtPath:destPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSArray *array = [self contentsForDirectoryPath:path];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             [self copyfileAtPath:[path stringByAppendingPathComponent:obj] destPath:[destPath stringByAppendingPathComponent:obj] completion:nil];
         }];
        if (completion)
        {
            completion(destPath);
        }
        return YES;
    }
}

@end
