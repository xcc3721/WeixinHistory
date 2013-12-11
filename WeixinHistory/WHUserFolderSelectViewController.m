//
//  WHUserFolderSelectViewController.m
//  WeixinHistory
//
//  Created by XCC on 12/11/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHUserFolderSelectViewController.h"

@interface WHUserFolderSelectViewController () <NSTableViewDataSource, NSTableViewDelegate>
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation WHUserFolderSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"User Folders";
}

#pragma mark -
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.userFolders count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *view = [tableView makeViewWithIdentifier:@"UserPath" owner:self];
    NSString *path = self.userFolders[row];
    [view.textField setStringValue:[path lastPathComponent]];
    return view;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    if (notification.object == self.tableView)
    {
        if (self.didSelectFolder) {
            self.didSelectFolder(self.userFolders[[self.tableView selectedRow]]);
        }
    }
}

@end
