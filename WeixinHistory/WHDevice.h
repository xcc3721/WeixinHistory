//
//  WHDevice.h
//  WeixinHistory
//
//  Created by XCC on 12/8/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHApp.h"

@interface WHDevice : NSObject


@property (nonatomic, readonly) NSString *udid;
@property (nonatomic, assign) NSInteger port;


- (instancetype)initWithDeviceUdid:(NSString *)udid;

- (void)connect;
- (void)disconnect;

- (void)startAFCService;
- (void)stopAFCService;

- (void)startInstallationService;
- (void)stopInstallationService;

- (void)startHouseArrest;
- (void)stopHouseArrest;

- (void)appWithAppId:(NSString *)appId handler:(void(^)(WHApp *app))handler;

- (NSString *)Model;
- (long long)freeBytes;
- (long long)totalBytes;
- (long)blockSize;

@end
