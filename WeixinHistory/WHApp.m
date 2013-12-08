//
//  WHApp.m
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHApp.h"
#import "NSDictionary+WHHelper.h"
#import "NSString+WHHelper.h"
#import "afc.h"
#import "WHAfcHelper.h"


@interface WHApp ()
{
    afc_client_t afc;
}

@end


@implementation WHApp

- (id)initWithHouseArrest:(house_arrest_client_t)house appid:(NSString *)appid
{
    if (house == nil || [appid length] == 0)
    {
        NSLog(@"Parameters not acceptable");
        return nil;
    }
    
    house_arrest_send_command(house, "VendDocuments", [appid UTF8String]);
    plist_t dict = nil;
    house_arrest_get_result(house, &dict);
    NSDictionary *result = [NSDictionary dictionaryFromPlist:dict];
    if (![result[@"Status"] isEqualToString:@"Complete"])
    {
        NSLog(@"get result error");
        return nil;
    }
    NSInteger ret = afc_client_new_from_house_arrest_client(house, &afc);
    if (ret != AFC_E_SUCCESS) {
        NSLog(@"AFC From HouseArrest Error:%ld", ret);
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (NSArray *)appContents
{
    return [WHAfcHelper contentsOfDirectory:@"/" afc:afc];
}

@end
