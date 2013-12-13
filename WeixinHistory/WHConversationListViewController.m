//
//  WHConversationViewController.m
//  WeixinHistory
//
//  Created by XCC on 12/10/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHConversationListViewController.h"
#import "WHConversationViewController.h"

@interface WHConversationListViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSArray *conversations;
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation WHConversationListViewController

- (void)dealloc
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

#pragma mark -

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.title = @"Conversation List";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadConversations];
}

- (void)loadConversations
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       [self.currentDevice weixinWithHandler:^(WHApp *app)
                       {
                           NSString *dbPath = [self.userPath stringByAppendingPathComponent:@"DB/MM.sqlite"];
                           [app copyfileAtPath:dbPath completion:^(NSString *localPath)
                            {
                                [[WHDBManager defaultManager] loadDatabase:localPath];
                                dispatch_async(dispatch_get_main_queue(), ^
                                               {
                                                   self.conversations = [[WHDBManager defaultManager] conversations];
                                                   [self.tableView reloadData];
                                               });
                            }];
                       }];
                   });
 
}


#pragma mark -
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.conversations count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *view = [tableView makeViewWithIdentifier:@"ConversationCell" owner:self];
    
    WHConversation *con = self.conversations[row];
    NSArray *contacts = [con contacts];
    [view.textField setStringValue:[[contacts lastObject] nickName]];
    
    return view;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    if (notification.object == self.tableView)
    {
        
        if ([self.tableView selectedRow] != -1)
        {
            WHConversationViewController *conversation = [WHConversationViewController new];
            conversation.conversation = self.conversations[[self.tableView selectedRow]];
            [self.navigationController pushViewController:conversation animated:YES];
            [conversation.view setTranslatesAutoresizingMaskIntoConstraints:NO];
            [[conversation.view superview] bindSameSizeWithSubview:conversation.view];

        }
        
    }
}

@end
