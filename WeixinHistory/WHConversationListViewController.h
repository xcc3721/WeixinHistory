//
//  WHConversationViewController.h
//  WeixinHistory
//
//  Created by XCC on 12/10/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHBaseViewController.h"

@interface WHConversationListViewController : WHBaseViewController

@property (nonatomic, strong) WHDevice *currentDevice;


- (void)loadConversations;

@end
