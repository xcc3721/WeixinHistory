//
//  WHAppDelegate.m
//  WeixinHistory
//
//  Created by XCC on 13-11-26.
//  Copyright (c) 2013年 XCC. All rights reserved.
//

#import "WHAppDelegate.h"
#import "WHMainWindowController.h"
#import "WHDeviceManager.h"


@interface WHAppDelegate ()

@property (nonatomic, strong) WHMainWindowController *mainWC;

@end


@implementation WHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.mainWC = [[WHMainWindowController alloc] init];
    [self.mainWC.window makeKeyAndOrderFront:nil];
}

@end
