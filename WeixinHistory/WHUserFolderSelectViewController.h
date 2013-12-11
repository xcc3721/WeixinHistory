//
//  WHUserFolderSelectViewController.h
//  WeixinHistory
//
//  Created by XCC on 12/11/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHBaseViewController.h"

@interface WHUserFolderSelectViewController : WHBaseViewController

@property (nonatomic, strong) NSArray *userFolders;

@property (nonatomic, copy) void (^didSelectFolder)(NSString *path);

@end
