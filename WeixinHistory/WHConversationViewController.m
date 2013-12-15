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
#import "WHMessageViewFactory.h"
#import "WHVoiceMessageView.h"

#import <AVFoundation/AVFoundation.h>


extern NSString * const WHWechatUserNameKey;

@interface WHConversationViewController () <WHVoiceMessageViewDelegate>

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
    [self.tableView registerNib:[[NSNib alloc] initWithNibNamed:@"WHMessageCellView_Received" bundle:nil] forIdentifier:@"ReceivedMessage"];
    [self.tableView registerNib:[[NSNib alloc] initWithNibNamed:@"WHMessageCellView_Sent" bundle:nil] forIdentifier:@"SentMessage"];
    [super awakeFromNib];
}

- (void)setConversation:(WHConversation *)conversation
{
    if (_conversation != conversation)
    {
        _conversation = conversation;
        WHContact *contact = [[_conversation contacts] lastObject];
        NSImage *image = [[NSImage alloc] initWithData:[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[contact imageURL]] returningResponse:nil error:nil]];
        self.frientAvatar = image;
        [[self.tableView enclosingScrollView] layoutSubtreeIfNeeded];
        [self.tableView reloadData];
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
    view.messageView.delegate = self;
    
    return view;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    WHMessage *message = [self.conversation messages][row];
    Class<WHMessageViewProtocol> class = [WHMessageViewFactory messageViewClassForMessage:message];
    return [class heightForMessage:message width:NSWidth(tableView.bounds) - 100];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.userAvatar = [NSImage imageNamed:@"defaultAvatar"];
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

#pragma mark -
- (void)playVoiceForMessage:(WHMessage *)message
{
    NSLog(@"%@", message);
    WHContact *contact = [[self.conversation contacts] lastObject];
    NSString *md5 = [[contact userName] MD5Digest];
    NSInteger num = message.localId;
    [self.device weixinWithHandler:^(WHApp *app)
     {
         NSString *audioPath = [self.userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/Audio/%@/%ld.aud", md5, num]];
         void (^handler)(NSString *) = ^(NSString *localPath)
         {
             NSMutableData *voice = [NSMutableData dataWithBytes:"#!AMR\n" length:6];
             [voice appendData:[NSData dataWithContentsOfFile:localPath]];
//             [voice writeToFile:localPath atomically:YES];
             
             NSError *error = nil;
             AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:voice error:&error];
             @try {
                 NSLog(@"%d", [player prepareToPlay]);
                 [player play];
             }
             @catch (NSException *exception) {
                 NSLog(@"%@", exception);
             }
             @finally {
                 
             }
             
             
         };
         if ([app copyfileAtPath:audioPath completion:handler])
        {
            NSLog(@"Voice file for [%@] not exists!", message);
        }
     }];
}

@end
