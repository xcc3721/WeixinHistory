//
//  WHDBManager.h
//  WeixinHistory
//
//  Created by XCC on 12/1/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHContact.h"
#import "WHConversation.h"

@interface WHDBManager : NSObject

+ (id)defaultManager;


- (void)loadDatabase:(NSString *)dbpath;

@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSArray *conversations;

@end
