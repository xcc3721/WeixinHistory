//
//  WHMessage.h
//  WeixinHistory
//
//  Created by XCC on 12/2/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, MessageDestination)
{
    MessageSent,
    MessageReceived,
};

typedef NS_ENUM(NSInteger, MessageType)
{
    MessageTypeText = 1,
    MessageTypeVoice = 34,
    MessageTypeAppShare = 49,
    MessageTypeSystem = 10000,
};

@interface WHMessage : NSObject

- (id)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, assign) NSInteger localId;
@property (nonatomic, assign) NSInteger serverId;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) MessageType type;
@property (nonatomic, assign) MessageDestination dest;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger imageStatus;

@end
