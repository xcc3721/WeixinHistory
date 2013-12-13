//
//  WHTextMessageView.m
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHTextMessageView.h"
#import "WHMessage.h"

@implementation WHTextMessageView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)setupView
{
    [self.layer setBackgroundColor:[NSColor redColor].CGColor];
    [self.textLabel setStringValue:[self.message message]];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"fasdf");
}
@end
