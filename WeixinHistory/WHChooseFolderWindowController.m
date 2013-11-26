//
//  WHChooseDirectoryWindowController.m
//  WeixinHistory
//
//  Created by XCC on 13-11-26.
//  Copyright (c) 2013年 XCC. All rights reserved.
//

#import "WHChooseFolderWindowController.h"
#import "WHMainWindowController.h"

@interface WHChooseFolderWindowController ()
@property (weak) IBOutlet NSTextField *folderField;
@property (nonatomic, strong) WHMainWindowController *mainWC;
@end

@implementation WHChooseFolderWindowController

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
}


- (IBAction)chooseFolder:(id)sender
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    [panel setCanCreateDirectories:NO];
    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result)
    {
        [self.folderField setStringValue:[panel.URL path]];
    }];
}

- (IBAction)goMainWindow:(id)sender
{
    [self.window orderOut:sender];
    self.mainWC = [WHMainWindowController new];
    self.mainWC.workingFolder = [NSURL URLWithString:self.folderField.stringValue];
    [self.mainWC.window makeKeyAndOrderFront:sender];
}

@end