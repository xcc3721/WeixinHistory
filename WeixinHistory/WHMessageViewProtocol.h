//
//  WHMessageViewProtocol.h
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WHMessage;

@protocol WHMessageViewDelegate <NSObject>

@end


@protocol WHMessageViewProtocol <NSObject>

+ (instancetype)viewWithMessage:(WHMessage *)message;

- (void)setupView;

+ (CGFloat)heightForMessage:(WHMessage *)message width:(CGFloat)width;

@property (weak, nonatomic) id<WHMessageViewDelegate> delegate;

@end
