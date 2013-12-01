//
//  WHMainWindowController.m
//  WeixinHistory
//
//  Created by XCC on 13-11-26.
//  Copyright (c) 2013年 XCC. All rights reserved.
//

#import "WHMainWindowController.h"
#import "WHDBManager.h"

@interface WHMainWindowController ()
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
    
    self.fileManager = [NSFileManager defaultManager];
    [[self.fileManager contentsOfDirectoryAtURL:self.workingFolder
                     includingPropertiesForKeys:@[]
                                        options:0 error:nil]
     enumerateObjectsWithOptions:NSEnumerationConcurrent
     usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        NSURL *content = obj;
        NSString *lastComponent = [content lastPathComponent];
        if ([[content resourceValuesForKeys:@[NSURLIsDirectoryKey] error:nil][NSURLIsDirectoryKey] boolValue] == YES && [lastComponent length] == 32 && ![lastComponent containsString:@"00000000000000000000000000000000"])
        {
            [WHDBManager setDBPath:[content URLByAppendingPathComponent:@"DB/MM.sqlite"].path];
            *stop = YES;
        }
    }];
    
    [WHDBManager defaultManager];
    
    
//    self.database = [FMDatabase databaseWithPath:self.workingFolder.path];
}

@end
