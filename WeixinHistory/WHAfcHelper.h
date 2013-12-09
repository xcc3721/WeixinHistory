//
//  WHAfcHelper.h
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "afc.h"

@interface WHAfcHelper : NSObject

+ (NSArray *)contentsOfDirectory:(NSString *)directoryPath afc:(afc_client_t)afc;
+ (NSDictionary *)fileInfo:(NSString *)path afc:(afc_client_t)afc;
+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDir afc:(afc_client_t)afc;

@end
