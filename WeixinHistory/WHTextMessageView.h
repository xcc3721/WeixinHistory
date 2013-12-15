//
//  WHTextMessageView.h
//  WeixinHistory
//
//  Created by XCC on 12/14/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WHBaseMessageView.h"

@interface WHTextMessageView : WHBaseMessageView


@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end
