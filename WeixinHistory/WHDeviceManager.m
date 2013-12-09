//
//  WHDeviceManager.m
//  WeixinHistory
//
//  Created by XCC on 12/8/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHDeviceManager.h"
#import "libimobiledevice.h"
#import "WHDevice.h"
#import "WHApp.h"
#import "NSString+WHHelper.h"

NSString * const WHDeviceManagerDeviceDidAddNotification = @"WHDeviceManagerDeviceDidAddNotification";
NSString * const WHDeviceManagerDeviceDidRemoveNotification = @"WHDeviceManagerDeviceDidRemoveNotification";
NSString * const WHDeviceKey = @"WHDeviceKey";

static WHDeviceManager *_manager = nil;

@interface WHDeviceManager ()

@property (nonatomic, strong) NSMutableDictionary *devices;


- (void)registerDevice:(WHDevice *)device;
- (void)unregisterDevice:(WHDevice *)device;
- (void)unregisterDeviceByUdid:(NSString *)udid;

@end


void DeviceEventCallBack(const idevice_event_t *event, void *user_data)
{
    if (event->event == IDEVICE_DEVICE_ADD)
    {
        NSLog(@"Device Add");
        WHDevice *device = [[WHDevice alloc] initWithDeviceUdid:[NSString udidFromCString:event->udid]];
        [_manager registerDevice:device];
    }
    else if (event->event == IDEVICE_DEVICE_REMOVE)
    {
        NSLog(@"Device Remove");
        NSString *udid = [NSString udidFromCString:event->udid];
        [_manager unregisterDeviceByUdid:udid];
    }
}

@implementation WHDeviceManager

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[WHDeviceManager alloc] init];
    });
    return _manager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _devices = [NSMutableDictionary dictionary];
        
        NSInteger rc = idevice_event_subscribe(&DeviceEventCallBack, nil);
        if(rc ==  IDEVICE_E_SUCCESS)
        {
            NSLog(@"DeviceManager subscribe callback successfully");
        }
        else
        {
            NSLog(@"DeviceManager subscrive callaback failed, error code:%ld", rc);
        }
    }
    return self;
}

- (void)registerDevice:(WHDevice *)device
{
    [device connect];
    self.devices[device.udid] = device;
    NSLog(@"Device Registed For Device:%@", device);
    [[NSNotificationCenter defaultCenter] postNotificationName:WHDeviceManagerDeviceDidAddNotification object:nil userInfo:@{WHDeviceKey : device}];
    if (self.deviceDidAdded)
    {
        self.deviceDidAdded(device);
    }
}

- (void)unregisterDevice:(WHDevice *)device
{
    [self unregisterDeviceByUdid:device.udid];
}

- (void)unregisterDeviceByUdid:(NSString *)udid
{
    if ([udid length] != 0)
    {
        WHDevice *device = self.devices[udid];
        [device disconnect];
        NSLog(@"Device Unregisted:%@", device);
        [self.devices removeObjectForKey:udid];
        [[NSNotificationCenter defaultCenter] postNotificationName:WHDeviceManagerDeviceDidRemoveNotification object:nil userInfo:@{WHDeviceKey : device}];
        if (self.deviceDidRemoved)
        {
            self.deviceDidRemoved(device);
        }
    }
}

- (NSDictionary *)currentDevices
{
    return [NSDictionary dictionaryWithDictionary:self.devices];
}

- (WHDevice *)deviceByUUID:(NSString *)uuid
{
    return self.devices[uuid];
}

@end
