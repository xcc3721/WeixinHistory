//
//  WHMessage+TableView.m
//  WeixinHistory
//
//  Created by Erick Xi on 12/13/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHMessage+TableView.h"

@implementation WHMessage (TableView)

- (CGFloat)heightForTableViewCell:(NSTableView *)tableView
{
    CGFloat height = 0;
    switch (self.type) {
        case MessageTypeText:
        {
            NSSize size = NSMakeSize(NSWidth(tableView.frame) - 30, CGFLOAT_MAX);
            NSRect rect = [self.message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [NSFont fontWithName:@"Helvetica" size:11.0]}];
            height = NSHeight(rect);
        }
            break;
            case MessageTypeAppShare:
        {
            return 14;
        }
            break;
            case MessageTypeVoice:
        {
            return 14;
        }
            break;
            case MessageTypeSystem:
        {
            return 14;
        }
            break;
            
        default:
            break;
    }
    return height;
}

@end
