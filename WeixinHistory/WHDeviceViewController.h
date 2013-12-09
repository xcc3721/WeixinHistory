//
//  WHDeviceViewController.h
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHBaseViewController.h"

@interface WHDeviceViewController : WHBaseViewController
@property (weak) IBOutlet NSTableView *tableView;


@property (nonatomic, strong) void(^didSelectDevice)(WHDevice *device);

@end
