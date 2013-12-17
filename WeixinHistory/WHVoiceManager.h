//
//  WHVoiceManager.h
//  WeixinHistory
//
//  Created by Erick Xi on 12/16/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WHVoiceOperation : NSOperation

+ (instancetype)operationWithVoicePath:(NSString *)path device:(WHDevice *)device;

@end


@interface WHVoiceManager : NSObject

+ (instancetype)defaultManager;
- (void)addVoiceOperation:(NSOperation *)operation;
- (void)stopAll;

@end
