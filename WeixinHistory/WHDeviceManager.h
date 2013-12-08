//
//  WHDeviceManager.h
//  WeixinHistory
//
//  Created by XCC on 12/8/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHDevice.h"

@interface WHDeviceManager : NSObject

+ (instancetype)defaultManager;

- (NSDictionary *)currentDevices;

@property (nonatomic, copy) void (^deviceDidAdded)(WHDevice *device);
@property (nonatomic, copy) void (^deviceDidRemoved)(WHDevice *device);

@end
