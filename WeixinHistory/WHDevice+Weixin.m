//
//  WHDevice+Weixin.m
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHDevice+Weixin.h"

@implementation WHDevice (Weixin)

- (void)weixinWithHandler:(void (^)(WHApp *))handler
{
    [self appWithAppId:@"com.tencent.xin" handler:handler];
}

@end
