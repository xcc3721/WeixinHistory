//
//  WHMainWindowController.h
//  WeixinHistory
//
//  Created by XCC on 13-11-26.
//  Copyright (c) 2013年 XCC. All rights reserved.
//

#import "WHBaseWindowController.h"

@interface WHMainWindowController : WHBaseWindowController

@property (nonatomic, copy) NSURL *workingFolder;
@property (nonatomic, copy) NSString *currentUDID;
@property (readonly) WHDevice *currentDevice;

@end
