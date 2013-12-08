//
//  NSDictionary+WHHelper.m
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "NSDictionary+WHHelper.h"
#import "XMLReader.h"

@implementation NSDictionary (WHHelper)

+ (instancetype)dictionaryFromPlist:(plist_t)plist
{
    char *xml = nil;
    uint32_t length = 0;
    plist_to_xml(plist, &xml, &length);
    NSString *string = [[NSString alloc] initWithBytes:xml length:length encoding:NSUTF8StringEncoding];
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"wh.plist"];
    [string writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return [NSDictionary dictionaryWithContentsOfFile:path];
//    return [XMLReader dictionaryForXMLString:string error:nil];
}

@end
