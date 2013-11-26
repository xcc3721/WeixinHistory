//
//  WHAppDelegate.m
//  WeixinHistory
//
//  Created by XCC on 13-11-26.
//  Copyright (c) 2013年 XCC. All rights reserved.
//

#import "WHAppDelegate.h"
#import "WHMainWindowController.h"
#import "WHChooseFolderWindowController.h"


@interface WHAppDelegate ()

@property (nonatomic, strong) WHChooseFolderWindowController *chooseFolderWC;

@end


@implementation WHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.chooseFolderWC = [WHChooseFolderWindowController new];
    [self.chooseFolderWC.window makeKeyAndOrderFront:nil];
}

@end
