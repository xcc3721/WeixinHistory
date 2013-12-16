//
//  WHBaseMessageView.m
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHBaseMessageView.h"
#import "WHMessage.h"

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

+ (instancetype)viewWithMessage:(WHMessage *)message
{
    WHBaseMessageView *result = [self makeView];
    result.message = message;
    [result setTranslatesAutoresizingMaskIntoConstraints:NO];
    [result setupView];
    return result;
}

+ (instancetype)makeView
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
    [result setWantsLayer:YES];
    return result;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setupView
{
    [self.layer setCornerRadius:10];
    NSColor *borderColor = nil;
    switch ([self.message dest]) {
        case MessageReceived:
        {
            borderColor = [NSColor blueColor];
        }
            break;
            case MessageSent:
        {
            borderColor = [NSColor redColor];
        }
            break;
            
        default:
            break;
    }
    [self.layer setBorderColor:borderColor.CGColor];
    [self.layer setBorderWidth:3];
}

+ (CGFloat)heightForMessage:(WHMessage *)message width:(CGFloat)width
{
    return 150;
}
@end
