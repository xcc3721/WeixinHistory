//
//  WHBaseViewController.m
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHBaseViewController.h"

@interface WHBaseViewController ()

@end

@implementation WHBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self)
    {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.view setWantsLayer:YES];
}

@end
