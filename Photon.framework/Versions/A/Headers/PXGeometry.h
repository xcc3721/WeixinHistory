//
//  PXGeometry.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photon/PhotonDefines.h>


typedef struct PXEdgeInsets {
    CGFloat top, left, bottom, right;
} PXEdgeInsets;


PHOTON_INLINE PXEdgeInsets PXEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    PXEdgeInsets insets = {top, left, bottom, right};
    return insets;
}


PHOTON_INLINE BOOL PXEdgeInsetsEqualToEdgeInsets(PXEdgeInsets insets1, PXEdgeInsets insets2) {
    return (insets1.top == insets2.top) && (insets1.left == insets2.left) && (insets1.bottom == insets2.bottom) && (insets1.right == insets2.right);
}


PHOTON_EXTERN const PXEdgeInsets PXEdgeInsetsZero;
