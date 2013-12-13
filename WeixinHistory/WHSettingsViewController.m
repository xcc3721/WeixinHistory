//
//  WHSettingsViewController.m
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHSettingsViewController.h"

NSString * const WHWechatUserNameKey = @"UserNameKey";

@interface WHSettingsViewController ()
@property (weak) IBOutlet NSTextField *userNameField;

@end

@implementation WHSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:WHWechatUserNameKey];
    if (userName)
    {
        [self.userNameField setStringValue:userName];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSString *userName = self.userNameField.stringValue;
    if (userName)
    {
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:WHWechatUserNameKey];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:WHWechatUserNameKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
