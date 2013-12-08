//
//  NSString+WHHelper.h
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WHHelper)

+ (NSString *)udidFromCString:(const char *)udid;
+ (NSString *)macAddress;
+ (char *)UTF8StringForApp;

@end
