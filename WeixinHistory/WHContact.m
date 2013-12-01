//
//  WHContact.m
//  WeixinHistory
//
//  Created by XCC on 12/1/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHContact.h"
#import "XMLReader.h"

@interface WHContact ()

@property (nonatomic, copy) NSString *detailXML;

@end


@implementation WHContact

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _nickName = dict[@"NickName"];
        _userName = dict[@"UsrName"];
        _gender = [dict[@"Sex"] integerValue];
        _email= dict[@"Email"];
        _detailXML = dict[@"ConStrRes2"];
        _detailXML = NSStringWithFormat(@"<Document>%@</Document>", _detailXML);
        
        NSError *error = nil;
        NSDictionary *detail = [XMLReader dictionaryForXMLString:_detailXML error:&error][@"Document"];
        if (error)
        {
            NSLog(@"%@", error);
        }
        NSString *imageURLPath = detail[@"HeadImgHDUrl"][@"text"];
        if (imageURLPath)
        {
            _imageURL = [NSURL URLWithString:imageURLPath];
        }
        
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"User:%@, NickName:%@", self.userName, self.nickName];
}

@end
