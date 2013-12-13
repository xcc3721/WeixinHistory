//
//  WHConversationViewController.m
//  WeixinHistory
//
//  Created by XCC on 12/12/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHConversationViewController.h"
#import "WHMessage.h"
#import "WHMessageCellView.h"
#import "WHMessage+TableView.h"

@interface WHConversationViewController ()

@property (nonatomic, strong) id strongSelf;

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

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.tableView registerNib:[[NSNib alloc] initWithNibNamed:@"WHTextMessageCellView" bundle:nil] forIdentifier:@"TextCell"];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[self.conversation messages] count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    WHMessageCellView *view = [tableView makeViewWithIdentifier:@"TextCell" owner:self];
    WHMessage *message = [self.conversation messages][row];
    [view setupWithMessage:message];
    return view;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    WHMessage *message = [self.conversation messages][row];
    NSSize size = NSMakeSize(NSWidth(tableView.frame) - 30, CGFLOAT_MAX);
    NSRect rect = [message.message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [NSFont fontWithName:@"Helvetica" size:11.0]}];
    CGFloat height = NSHeight(rect);
    return height;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    self.strongSelf = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.strongSelf = nil;
    
}

@end
