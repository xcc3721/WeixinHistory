//
//  WHMainWindowController.m
//  WeixinHistory
//
//  Created by XCC on 13-11-26.
//  Copyright (c) 2013年 XCC. All rights reserved.
//

#import "WHMainWindowController.h"
#import "WHDBManager.h"
#import "ITSidebar.h"
#import "WHDeviceManager.h"
#import "WHDeviceViewController.h"
#import "WHContactsViewController.h"
#import "WHConversationListViewController.h"
#import "WHNoneDeviceViewController.h"

@interface WHMainWindowController () <NSPopoverDelegate>

@property (weak) IBOutlet NSView *containerView;
@property (weak) IBOutlet ITSidebar *sidebar;
@property (nonatomic, weak) NSFileManager *fileManager;
@property (nonatomic, strong) NSViewController *currentViewController;

@end

@implementation WHMainWindowController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [[WHDeviceManager defaultManager] setDeviceDidAdded:^(WHDevice *device)
     {
         [device startAFCService];
         [device startInstallationService];
         [device startHouseArrest];
     }];
    [[WHDeviceManager defaultManager] setDeviceDidRemoved:^(WHDevice *device)
     {
         NSLog(@"%@", device);
     }];
    
    
    [self.sidebar setCellSize:NSMakeSize(100, 80)];
    
    [self.sidebar addItemWithImage:[NSImage cellImageNamed:@"contacts"] target:self action:@selector(showContacts:)];
    [self.sidebar addItemWithImage:[NSImage cellImageNamed:@"chat"] target:self action:@selector(showConversations:)];
    [self.sidebar addItemWithImage:[NSImage cellImageNamed:@"apple"] target:self action:@selector(showDevicePopover:)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidAdd:) name:WHDeviceManagerDeviceDidAddNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRemove:) name:WHDeviceManagerDeviceDidRemoveNotification object:nil];
    
    [self switchToContentViewController:[WHNoneDeviceViewController new]];
    
    
}

#pragma mark -
- (void)deviceDidAdd:(NSNotification *)notification
{
    if (self.currentUDID == nil)
    {
        self.currentUDID = [notification.userInfo[WHDeviceKey] udid];
    }
}

- (void)deviceDidRemove:(NSNotification *)notification
{
    WHDevice *device = notification.userInfo[WHDeviceKey];
    if ([self currentUDID] == [device udid])
    {
        self.currentUDID = [[[[WHDeviceManager defaultManager] currentDevices] allKeys] lastObject];
    }
    
    if (self.currentUDID == nil)
    {
        [self switchToContentViewController:[WHNoneDeviceViewController new]];
    }
}

#pragma mark -

- (IBAction)showContacts:(id)sender
{
    NSLog(@"Show Contacts");
    [self switchToContentViewController:[WHContactsViewController new]];
}

- (IBAction)showConversations:(id)sender
{
    NSLog(@"Show conversations");
    WHConversationListViewController *clvc = [WHConversationListViewController new];
    [clvc setCurrentDevice:self.currentDevice];
    [self switchToContentViewController:clvc];
    [clvc loadConversations];
}

- (IBAction)showDevicePopover:(id)sender
{
    NSPopover *popover = [[NSPopover alloc] init];
    [popover setBehavior:NSPopoverBehaviorTransient];
    [popover setAppearance:NSPopoverAppearanceHUD];
    WHDeviceViewController *vc = [WHDeviceViewController new];
    [popover setDelegate:self];
    [popover setContentViewController:vc];
    [vc setDidSelectDevice:^(WHDevice *device)
     {
         self.currentUDID = device.udid;
         [popover performClose:sender];
     }];
    
    [popover showRelativeToRect:[sender cellFrameAtRow:[sender selectedRow] column:[sender selectedColumn]] ofView:sender preferredEdge:NSMaxXEdge];
}

- (void)switchToContentViewController:(NSViewController *)vc
{
    if (vc != self.currentViewController)
    {
        [self replaceView:self.currentViewController.view withView:vc.view];
    }
    self.currentViewController = vc;
}

- (void)replaceView:(NSView *)oldView withView:(NSView *)newView
{
    [self.containerView addSubview:newView];
    [oldView removeFromSuperview];
    
    [newView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.containerView bindSameSizeWithSubview:newView];
    
    CATransition *transition = [CATransition animation];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transition setType:kCATransitionReveal];
    [transition setSubtype:kCATransitionFromLeft];
    [transition setDuration:.5];
    
    
    [self.containerView.layer addAnimation:transition forKey:@"transition"];
    
}

- (WHDevice *)currentDevice
{
    if (self.currentUDID)
    {
        return [[WHDeviceManager defaultManager] currentDevices][self.currentUDID];
    }
    return nil;
}

@end
