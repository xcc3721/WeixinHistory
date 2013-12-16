//
//  WHVoiceManager.m
//  WeixinHistory
//
//  Created by Erick Xi on 12/16/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHVoiceManager.h"
#import <AVFoundation/AVFoundation.h>

@interface WHVoiceOperation () <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) WHDevice *device;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) BOOL isPlaying;

@end

@implementation WHVoiceOperation

+ (instancetype)operationWithVoicePath:(NSString *)path device:(WHDevice *)device
{
    WHVoiceOperation *op = [[WHVoiceOperation alloc] init];
    [op setDevice:device];
    [op setPath:path];
    return op;
}

- (void)main
{
    [self.device weixinWithHandler:^(WHApp *app)
     {
         [app copyfileAtPath:self.path completion:^(NSString *localPath)
          {
              NSMutableData *voice = [NSMutableData dataWithBytes:"#!AMR\n" length:6];
              [voice appendData:[NSData dataWithContentsOfFile:localPath]];
              
              NSError *error = nil;
              self.player = [[AVAudioPlayer alloc] initWithData:voice error:&error];
              [self.player setDelegate:self];
              [self.player play];
              self.isPlaying = YES;
              while (self.isPlaying) {
                  [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
              }
              
              
          }];
     }];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.isPlaying = NO;
    [self performSelector:@selector(finishPlaying:) withObject:nil];
}

- (void)finishPlaying:(id)sender
{
    
}

@end


@interface WHVoiceManager ()

@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation WHVoiceManager

+ (instancetype)defaultManager
{
    static WHVoiceManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[WHVoiceManager alloc] init];
    });
    return _manager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:1];
        [_queue setSuspended:NO];
    }
    return self;
}

- (void)addVoiceOperation:(NSOperation *)operation
{
    [self.queue addOperation:operation];
}

@end
