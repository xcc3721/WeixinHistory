//
//  PXAnchoredButton.h
//  Schoolhouse
//
//  Created by Logan Collins on 12/27/10.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PXAnchoredButton : NSButton <NSValidatedUserInterfaceItem>

@end


@interface PXAnchoredButtonCell : NSButtonCell

@end


@interface NSObject (PXAnchoredButtonValidation)

- (BOOL)validateAnchoredButton:(PXAnchoredButton *)anchoredButton;

@end
