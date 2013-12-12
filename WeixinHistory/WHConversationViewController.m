//
//  WHConversationViewController.m
//  WeixinHistory
//
//  Created by XCC on 12/12/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHConversationViewController.h"
#import "WHMessage.h"

@interface WHConversationViewController ()

@end

@implementation WHConversationViewController

-(void)dealloc
{
    [self.tableView setDelegate:nil];
    [self.tableView setDataSource:nil];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[self.conversation messages] count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *view = [tableView makeViewWithIdentifier:@"Message" owner:self];
    WHMessage *message = [self.conversation messages][row];
    [view.textField setStringValue:[message message]];
    return view;
    
}

//- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
//{
//    
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

@end
