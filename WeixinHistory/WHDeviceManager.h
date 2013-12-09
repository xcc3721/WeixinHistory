//
//  WHDeviceManager.h
//  WeixinHistory
//
//  Created by XCC on 12/8/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHDevice.h"

extern NSString * const WHDeviceManagerDeviceDidAddNotification;
extern NSString * const WHDeviceManagerDeviceDidRemoveNotification;
extern NSString * const WHDeviceKey;

@interface WHDeviceManager : NSObject

+ (instancetype)defaultManager;

- (NSDictionary *)currentDevices;

- (WHDevice *)deviceByUUID:(NSString *)uuid;

@property (nonatomic, copy) void (^deviceDidAdded)(WHDevice *device);
@property (nonatomic, copy) void (^deviceDidRemoved)(WHDevice *device);

@end
