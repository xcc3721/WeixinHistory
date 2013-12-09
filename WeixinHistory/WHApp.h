//
//  WHApp.h
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "house_arrest.h"

@interface WHApp : NSObject

@property (readonly, nonatomic) NSString *appid;

- (instancetype)initWithHouseArrest:(house_arrest_client_t)house appid:(NSString *)appid;

- (NSArray *)appContents;
- (NSDictionary *)infoForFilePath:(NSString *)path;
- (NSArray *)contentsForDirectoryPath:(NSString *)path;
- (BOOL)copyfileAtPath:(NSString *)path completion:(void (^)(NSString *localPath))completion;
@end
