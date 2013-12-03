//
//  WHMessage.m
//  WeixinHistory
//
//  Created by XCC on 12/2/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHMessage.h"

@interface WHMessage ()

@property (nonatomic, strong) NSDictionary *messageDict;

@end

@implementation WHMessage

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _createTime = [NSDate dateWithTimeIntervalSince1970:[dict[@"CreateTime"] doubleValue]];
        _message = dict[@"Message"];
        _localId = [dict[@"MesLocalID"] integerValue];
        _serverId = [dict[@"MesSvrID"] integerValue];
        _type = [dict[@"Type"] integerValue];
        _dest = [dict[@"Des"] integerValue];
        _status = [dict[@"Status"] integerValue];
        _imageStatus = [dict[@"ImgStatus"] integerValue];
        
        _messageDict = dict;
    }
    return self;
}

@end
