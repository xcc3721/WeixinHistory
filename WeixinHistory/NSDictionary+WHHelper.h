//
//  NSDictionary+WHHelper.h
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "plist.h"

@interface NSDictionary (WHHelper)

+ (instancetype)dictionaryFromPlist:(plist_t)plist;
+ (instancetype)dictionaryFromCharArray:(char **)array;

@end
