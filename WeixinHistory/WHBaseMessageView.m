//
//  WHBaseMessageView.m
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHBaseMessageView.h"
@interface WHBaseMessageView ()
@property (readwrite, nonatomic, strong) WHMessage *message;
@end

@implementation WHBaseMessageView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (instancetype)initWithMessage:(WHMessage *)message
{
    NSNib *nib = [[NSNib alloc] initWithNibNamed:NSStringFromClass([self class]) bundle:nil];
    NSArray *array = nil;
    if(![nib instantiateWithOwner:self topLevelObjects:&array])
    {
        return nil;
    }
    __block WHBaseMessageView *result = nil;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        if ([obj isKindOfClass:[self class]]) {
            result = obj;
            *stop = YES;
        }
    }];
    result.message = message;
    [result setTranslatesAutoresizingMaskIntoConstraints:NO];
    [result setupView];
    self = result;
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setupView
{
    
}
@end
