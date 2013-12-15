//
//  WHConversationViewController.h
//  WeixinHistory
//
//  Created by XCC on 12/12/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHBaseViewController.h"

@interface WHConversationViewController : WHBaseViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) WHConversation *conversation;
@property (nonatomic, strong) WHDevice *device;
@property (nonatomic, copy) NSString *userPath;

@property (weak) IBOutlet NSTableView *tableView;

@end
