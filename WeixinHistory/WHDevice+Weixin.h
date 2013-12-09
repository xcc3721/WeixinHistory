//
//  WHDevice+Weixin.h
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHDevice.h"

@interface WHDevice (Weixin)

- (void)weixinWithHandler:(void(^)(WHApp *app))handler;

@end
