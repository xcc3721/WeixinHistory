//
//  WHContact.h
//  WeixinHistory
//
//  Created by XCC on 12/1/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ENUM(NSInteger, WHContactGender)
{
    WHContactGenderUnknown,
    WHContactGenderMale,
    WHContactGenderFemale,
};

@interface WHContact : NSObject

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) enum WHContactGender gender;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSURL *imageURL;


- (id)initWithDictionary:(NSDictionary *)dict;

@end
