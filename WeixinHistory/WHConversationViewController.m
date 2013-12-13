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


extern NSString * const WHWechatUserNameKey;

@interface WHConversationViewController ()

@property (nonatomic, strong) id strongSelf;
@property (nonatomic, strong) NSImage *frientAvatar;
@property (nonatomic, strong) NSImage *userAvatar;

@end

@implementation WHConversationViewController

-(void)dealloc
{
    [self.tableView setDelegate:nil];
    [self.tableView setDataSource:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self.tableView registerNib:[[NSNib alloc] initWithNibNamed:@"WHMessageCellView_Received" bundle:nil] forIdentifier:@"ReceivedMessage"];
    [self.tableView registerNib:[[NSNib alloc] initWithNibNamed:@"WHMessageCellView_Sent" bundle:nil] forIdentifier:@"SentMessage"];

}

- (void)setConversation:(WHConversation *)conversation
{
    if (_conversation != conversation)
    {
        _conversation = conversation;
        WHContact *contact = [[_conversation contacts] lastObject];
        NSImage *image = [[NSImage alloc] initWithData:[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[contact imageURL]] returningResponse:nil error:nil]];
        self.frientAvatar = image;
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[self.conversation messages] count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    WHMessage *message = [self.conversation messages][row];
    NSString *identifier = nil;
    NSImage *avatar = nil;
    if (message.dest == MessageReceived) {
        identifier = @"ReceivedMessage";
        avatar = self.frientAvatar;
    }
    else
    {
        identifier = @"SentMessage";
        avatar = self.userAvatar;
    }
    WHMessageCellView *view = [tableView makeViewWithIdentifier:identifier owner:self];
    
    [view setupWithMessage:message];
    [view.avatarImageView setImage:avatar];
    
    NSLog(@"%@", view.containerView);
    
    return view;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 200;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:WHWechatUserNameKey];
//    if (userName)
//    {
//        NSHTTPURLResponse *response = nil;
//        NSError *err = nil;
//        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://wx.qq.com/cgi-bin/mmwebwx-bin/webwxgeticon?username=%@", userName]]] returningResponse:&response error:&err];
//        NSImage *image = [[NSImage alloc] initWithData:data];
//        self.userAvatar = image;
//    }
//    else
    {
        self.userAvatar = [NSImage imageNamed:@"defaultAvatar"];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    self.strongSelf = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResize:) name:NSWindowDidEndLiveResizeNotification object:nil];
}

- (void)windowDidResize:(NSNotification *)notification
{
    NSLog(@"%@", notification);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.strongSelf = nil;
    
}

@end
