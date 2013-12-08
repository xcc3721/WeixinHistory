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

@interface WHMainWindowController ()
@property (strong) IBOutlet NSView *yellowView;
@property (strong) IBOutlet NSView *redView;
@property (weak) IBOutlet NSView *containerView;
@property (weak) IBOutlet ITSidebar *sidebar;
@property (nonatomic, weak) NSFileManager *fileManager;
@end

@implementation WHMainWindowController

- (void)dealloc
{
    
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
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    //    self.fileManager = [NSFileManager defaultManager];
    //    [[self.fileManager contentsOfDirectoryAtURL:self.workingFolder
    //                     includingPropertiesForKeys:@[]
    //                                        options:0 error:nil]
    //     enumerateObjectsWithOptions:NSEnumerationConcurrent
    //     usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    //    {
    //        NSURL *content = obj;
    //        NSString *lastComponent = [content lastPathComponent];
    //        if ([[content resourceValuesForKeys:@[NSURLIsDirectoryKey] error:nil][NSURLIsDirectoryKey] boolValue] == YES && [lastComponent length] == 32 && ![lastComponent containsString:@"00000000000000000000000000000000"])
    //        {
    //            [WHDBManager setDBPath:[content URLByAppendingPathComponent:@"DB/MM.sqlite"].path];
    //            *stop = YES;
    //        }
    //    }];
    
    
    [WHDBManager defaultManager];
    [[WHDeviceManager defaultManager] setDeviceDidAdded:^(WHDevice *device)
     {
         [device startAFCService];
         [device startInstallationService];
         [device startHouseArrest];
         [device appWithAppId:@"com.tencent.xin" handler:^(WHApp *app)
         {
             NSLog(@"%@", [app appContents]);
         }];
         
         [device appWithAppId:@"com.inmethod.AirVideoHD" handler:^(WHApp *app)
         {
             NSLog(@"%@", [app appContents]);
         }];
     }];
    [[WHDeviceManager defaultManager] setDeviceDidRemoved:^(WHDevice *device)
    {
        NSLog(@"%@", device);
    }];
    
    
    [self.sidebar setCellSize:NSMakeSize(100, 80)];
    
    [self.sidebar addItemWithImage:[NSImage cellImageNamed:@"contacts"] target:self action:@selector(showContacts:)];
    [self.sidebar addItemWithImage:[NSImage cellImageNamed:@"chat"] target:self action:@selector(showConversations:)];
    
    [self.redView.layer setBackgroundColor:[NSColor redColor].CGColor];
    [self.yellowView.layer setBackgroundColor:[NSColor yellowColor].CGColor];
    
    
}

- (IBAction)showContacts:(id)sender
{
    NSLog(@"Show Contacts");
}

- (IBAction)showConversations:(id)sender
{
    NSLog(@"Show conversations");
}

- (IBAction)test:(id)sender
{
    [self switchToContentViewController:nil];
}

- (void)switchToContentViewController:(NSViewController *)vc
{
    //    [self.containerView addSubview:self.redView];
    if ([self.redView superview])
    {
        [self replaceView:self.redView withView:self.yellowView];
    }
    else
    {
        [self replaceView:self.yellowView withView:self.redView];
    }
    
}

- (void)replaceView:(NSView *)oldView withView:(NSView *)newView
{
    [self.containerView addSubview:newView];
    
    CATransition *transition = [CATransition animation];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transition setType:@"push"];
    [transition setSubtype:kCATransitionFromLeft];
    [transition setDuration:5];
    
    
    [newView.layer addAnimation:transition forKey:@"transition"];
    [oldView.layer addAnimation:transition forKey:@"transition"];
    [oldView removeFromSuperview];
}

@end
