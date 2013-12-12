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
#import "WHGuideDeviceViewController.h"

@interface WHMainWindowController () <NSPopoverDelegate>

@property (weak) IBOutlet NSView *containerView;
@property (weak) IBOutlet ITSidebar *sidebar;
@property (nonatomic, weak) NSFileManager *fileManager;
@property (nonatomic, strong) NSViewController *currentViewController;
@property (nonatomic, copy) NSString *userPath;

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
        [self switchToContentViewController:[WHGuideDeviceViewController new]];
    }
}

- (void)deviceDidRemove:(NSNotification *)notification
{
    WHDevice *device = notification.userInfo[WHDeviceKey];
    if ([self currentUDID] == [device udid])
    {
        self.currentUDID = nil;
    }
    [self handleLosingCurrentDevice];
}

#pragma mark -

- (void)handleLosingCurrentDevice
{
    if ([self.sidebar.matrix numberOfRows] > 1)
    {
        [self.sidebar.matrix removeRow:2];
        [self.sidebar.matrix removeRow:1];
    }
    if ([[[WHDeviceManager defaultManager] currentDevices] count])
    {
        [self switchToContentViewController:[WHGuideDeviceViewController new]];
    }
    else
    {
        [self switchToContentViewController:[WHNoneDeviceViewController new]];
    }
}

- (IBAction)showContacts:(id)sender
{
    NSLog(@"Show Contacts");
    if (self.currentUDID)
    {
        [self switchToContentViewController:[WHContactsViewController new]];
    }
    else
    {
        [self handleLosingCurrentDevice];
    }
}

- (IBAction)showConversations:(id)sender
{
    NSLog(@"Show conversations");
    if (self.currentUDID)
    {
        WHConversationListViewController *clvc = [WHConversationListViewController new];
        [clvc setCurrentDevice:self.currentDevice];
        [clvc setUserPath:self.userPath];
        
        PXNavigationController *nc = [[PXNavigationController alloc] initWithRootViewController:clvc];
        
        [self switchToContentViewController:nc];
    }
    else
    {
        [self handleLosingCurrentDevice];
    }
}

- (IBAction)showDevicePopover:(id)sender
{
    NSPopover *popover = [[NSPopover alloc] init];
    [popover setBehavior:NSPopoverBehaviorTransient];
    
    WHDeviceViewController *vc = [WHDeviceViewController new];
    [popover setDelegate:self];
    [vc setDidSelectDevice:^(WHDevice *device, NSString *userPath)
     {
         self.currentUDID = device.udid;
         self.userPath = userPath;
         
         if ([self.sidebar.matrix numberOfRows] == 1)
         {
             [self.sidebar addItemWithImage:[NSImage cellImageNamed:@"contacts"] target:self action:@selector(showContacts:)];
             [self.sidebar addItemWithImage:[NSImage cellImageNamed:@"chat"] target:self action:@selector(showConversations:)];
         }
         
         
         [self.sidebar.matrix selectCellAtRow:2 column:0];
         [self showConversations:sender];
         
         
         
         [popover performClose:sender];
     }];
    PXNavigationController *nc = [[PXNavigationController alloc] initWithRootViewController:vc];
    popover.contentViewController = nc;
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
