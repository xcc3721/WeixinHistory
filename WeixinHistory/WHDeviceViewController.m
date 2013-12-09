//
//  WHDeviceViewController.m
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHDeviceViewController.h"
#import "WHDeviceTableViewCell.h"

@interface WHDeviceViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSArray *devices;

@end

@implementation WHDeviceViewController

- (void)dealloc
{
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
    self.devices = [[[WHDeviceManager defaultManager] currentDevices] allValues];
    [self.tableView setBackgroundColor:[NSColor clearColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidChange:) name:WHDeviceManagerDeviceDidAddNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidChange:) name:WHDeviceManagerDeviceDidRemoveNotification object:nil];
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [self.tableView reloadData];
                   });
}

#pragma mark -
- (void)deviceDidChange:(NSNotification *)notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       self.devices = [[[WHDeviceManager defaultManager] currentDevices] allValues];
                       [self.tableView reloadData];
                   });
    
}

#pragma mark -
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.devices count];
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    WHDeviceTableViewCell *view = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    WHDevice *device = self.devices[row];
    NSImage *image = nil;
    if ([device.Model containsString:@"ipad"])
    {
        image = [NSImage deviceImageNamed:@"ipad"];
    }
    else
    {
        image = [NSImage deviceImageNamed:@"iphone"];
    }
    [view.imageView setImage:image];
    
    return view;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row
{
    NSTableRowView *rowView = [tableView makeViewWithIdentifier:@"RowView" owner:self];
    [rowView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
    return rowView;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    if (notification.object == self.tableView && self.didSelectDevice)
    {
        WHDevice *device = self.devices[[self.tableView selectedRow]];
        self.didSelectDevice(device);
    }
}

@end
