//
//  WHDevice.m
//  WeixinHistory
//
//  Created by XCC on 12/8/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHDevice.h"
#import "libimobiledevice.h"
#import "lockdown.h"
#import "afc.h"
#import "heartbeat.h"
#import "installation_proxy.h"
#import "house_arrest.h"
#import "XMLReader.h"
#import "NSString+WHHelper.h"
#import "NSDictionary+WHHelper.h"
#import "WHAfcHelper.h"

@interface WHDevice ()
{
    idevice_t device;
    idevice_connection_t connection;
    afc_client_t devafc;
    instproxy_client_t devinst;
    house_arrest_client_t devhouse;
}


@property (nonatomic, strong) NSMutableDictionary *deviceInfo;

@end


@implementation WHDevice

- (void)dealloc
{
    [self stopAFCService];
    [self stopInstallationService];
    [self stopHouseArrest];
    [self disconnect];
    idevice_free(device);
}

- (instancetype)initWithDeviceUdid:(NSString *)udid
{
    self = [super init];
    if (self)
    {
        _udid = [udid copy];
        idevice_new(&device, [udid UTF8String]);
        connection = nil;
        _deviceInfo = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)connect
{
    if (connection == nil)
    {
        NSInteger ret = idevice_connect(device, 62078, &connection);
        
        if (ret == IDEVICE_E_SUCCESS)
        {
            NSLog(@"Device did connected:%@", self);
        }
        else
        {
            NSLog(@"Device connect failed, error code:%ld", ret);
        }
    }
    else
    {
        NSLog(@"Device already connected:%@", self);
    }
}

- (void)disconnect
{
    if (connection != nil)
    {
        NSInteger ret = idevice_disconnect(connection);
        if (ret == IDEVICE_E_SUCCESS)
        {
            NSLog(@"Device did disconnected:%@", self);
            connection = nil;
        }
        else
        {
            NSLog(@"Device connect failed, eror code:%ld", ret);
        }
    }
    else
    {
        NSLog(@"Device already disconnected:%@", self);
    }
}

#pragma mark - AFC

- (void)startAFCService
{
    if (devafc != nil)
    {
        NSLog(@"AFC Service already running!");
        return;
    }
    NSInteger ret = afc_client_start_service(device, &devafc, [NSString UTF8StringForApp]);
    if (ret == AFC_E_SUCCESS)
    {
        NSLog(@"AFC Service Started!");
        [self getDeviceInfo];
        NSLog(@"%@", [WHAfcHelper contentsOfDirectory:@"/private" afc:devafc]);
    }
    else
    {
        NSLog(@"AFC Service start failed, error code:%ld", ret);
    }
}



- (void)stopAFCService
{
    if (devafc != nil)
    {
        afc_client_free(devafc);
        devafc = nil;
        NSLog(@"AFC Service Stopped!");
    }
}

#pragma mark - InstallationProxy
- (void)startInstallationService
{
    if (devinst != nil)
    {
        NSLog(@"InstallationProxy Service already running!");
        return;
    }
    NSInteger ret = instproxy_client_start_service(device, &devinst, [NSString UTF8StringForApp]);
    if (ret == INSTPROXY_E_SUCCESS)
    {
        NSLog(@"InstallationProxy Service Started");
        
    }
    else
    {
        NSLog(@"InstallationProxy Service failed, error code:%ld", ret);
    }
}

- (void)stopInstallationService
{
    if (devinst != nil)
    {
        instproxy_client_free(devinst);
        devinst = nil;
    }
}

#pragma mark - HouseArrest
- (void)startHouseArrest
{
    if (devhouse != nil)
    {
        NSLog(@"HouseArrest Service already running!");
        return;
    }
    NSInteger ret = house_arrest_client_start_service(device, &devhouse, [NSString UTF8StringForApp]);
    if (ret == HOUSE_ARREST_E_SUCCESS)
    {
        NSLog(@"HouseArrest Service Started");
        
    }
    else
    {
        NSLog(@"HouseArrest Service failed, error code:%ld", ret);
    }
}

- (void)stopHouseArrest
{
    if (devhouse != nil)
    {
        house_arrest_client_free(devhouse);
        devhouse = nil;
    }
}



#pragma mark - App
- (void)appWithAppId:(NSString *)appId handler:(void (^)(WHApp *))handler
{
    [self stopHouseArrest];
    [self startHouseArrest];
    if (handler)
    {
        handler([[WHApp alloc] initWithHouseArrest:devhouse appid:appId]);
    }
    [self stopHouseArrest];
    [self startHouseArrest];
}



#pragma mark - Device Info

- (void)getDeviceInfo
{
    [self.deviceInfo removeAllObjects];
    char **info = nil;
    if(afc_get_device_info(devafc, &info) == AFC_E_SUCCESS)
    {
        NSInteger i = 0;
        while (info[i] != nil)
        {
            NSString *key = [NSString stringWithCString:info[i++] encoding:NSUTF8StringEncoding];
            NSString *value = [NSString stringWithCString:info[i++] encoding:NSUTF8StringEncoding];
            self.deviceInfo[key] = value;
        }
        NSLog(@"Device Info received");
    }
    else
    {
        NSLog(@"Get device info failed");
    }
}

- (NSString *)Model
{
    NSString *result = self.deviceInfo[@"Model"];
    if (result == nil)
    {
        char *model = nil;
        afc_get_device_info_key(devafc, "Model", &model);
        if (model)
        {
            result = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
        }
    }
    return result;
}

- (long long)freeBytes
{
    NSString *result = self.deviceInfo[@"FSFreeBytes"];
    if (result == nil)
    {
        char *bytes = nil;
        afc_get_device_info_key(devafc, "FSFreeBytes", &bytes);
        result = [NSString stringWithCString:bytes encoding:NSUTF8StringEncoding];
    }
    return [result longLongValue];
}

- (long long)totalBytes
{
    NSString *result = self.deviceInfo[@"FSTotalBytes"];
    if (result == nil)
    {
        char *bytes = nil;
        afc_get_device_info_key(devafc, "FSTotalBytes", &bytes);
        result = [NSString stringWithCString:bytes encoding:NSUTF8StringEncoding];
    }
    return [result longLongValue];
}

- (long)blockSize
{
    NSString *result = self.deviceInfo[@"FSBlockSize"];
    if (result == nil)
    {
        char *bytes = nil;
        afc_get_device_info_key(devafc, "FSBlockSize", &bytes);
        result = [NSString stringWithCString:bytes encoding:NSUTF8StringEncoding];
    }
    return [result integerValue];
}

#pragma mark -

- (NSString *)description
{
    NSDictionary *dict = @{@"Udid": self.udid};
    return [dict description];
}

@end
