//
//  WHDBManager.h
//  WeixinHistory
//
//  Created by XCC on 12/1/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHDBManager : NSObject

+ (id)defaultManager;
+ (void)setDBPath:(NSString *)path;

@end
