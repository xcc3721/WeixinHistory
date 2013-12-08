//
//  NSString+WHHelper.m
//  WeixinHistory
//
//  Created by XCC on 12/9/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "NSString+WHHelper.h"

#import <sys/socket.h>
#import <net/if_dl.h>
#import <ifaddrs.h>
#import <sys/xattr.h>
#define IFT_ETHER 0x6

@implementation NSString (WHHelper)

+ (NSString *)udidFromCString:(const char *)udid
{
    return [[NSString alloc] initWithBytes:udid length:41 encoding:NSUTF8StringEncoding];
}

+ (NSString *)macAddress
{
    NSString* result = nil;
    
    char* macAddressString = (char*)malloc(18);
    if (macAddressString != NULL)
    {
        strcpy(macAddressString, "");
        
        struct ifaddrs* addrs = NULL;
        struct ifaddrs* cursor;
        
        if (getifaddrs(&addrs) == 0)
        {
            cursor = addrs;
            
            while (cursor != NULL)
            {
                if ((cursor->ifa_addr->sa_family == AF_LINK) && (((const struct sockaddr_dl*)cursor->ifa_addr)->sdl_type == IFT_ETHER) && strcmp("en0", cursor->ifa_name) == 0)
                {
                    const struct sockaddr_dl* dlAddr = (const struct sockaddr_dl*) cursor->ifa_addr;
                    const unsigned char* base = (const unsigned char*)&dlAddr->sdl_data[dlAddr->sdl_nlen];
                    
                    for (NSInteger index = 0; index < dlAddr->sdl_alen; index++)
                    {
                        char partialAddr[3];
                        
                        sprintf(partialAddr, "%02X", base[index]);
                        strcat(macAddressString, partialAddr);
                    }
                }
                
                cursor = cursor->ifa_next;
            }
            
        }
        
        result = [[NSString alloc] initWithUTF8String:macAddressString];
        
        free(macAddressString);
    }
    
    return result;
}

+ (char *)UTF8StringForApp
{
    return "WeixinHistory";
}


@end
