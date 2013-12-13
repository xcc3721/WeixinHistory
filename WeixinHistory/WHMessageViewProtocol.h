//
//  WHMessageViewProtocol.h
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WHMessage;

@protocol WHMessageViewProtocol <NSObject>

- (instancetype)initWithMessage:(WHMessage *)message;

- (void)setupView;

@end
