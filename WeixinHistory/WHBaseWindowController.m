//
//  WHBaseWindowController.m
//  WeixinHistory
//
//  Created by XCC on 13-11-26.
//  Copyright (c) 2013年 XCC. All rights reserved.
//

#import "WHBaseWindowController.h"

@interface WHBaseWindowController ()

@end

@implementation WHBaseWindowController

- (id)init
{
    self = [super initWithWindowNibName:NSStringFromClass([self class])];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [(NSView *)self.window.contentView setWantsLayer:YES];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
