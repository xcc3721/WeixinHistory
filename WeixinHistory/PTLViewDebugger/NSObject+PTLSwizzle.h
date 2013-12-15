//
//  NSObject+PTLSwizzle.h
//  PTLDatasource
//
//  Created by Brian Partridge on 8/30/13.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (PTLSwizzle)

+ (BOOL)ptl_swizzleMethod:(SEL)originalSelector withMethod:(SEL)newSelector;
+ (BOOL)ptl_swizzleClassMethod:(SEL)originalSelector withClassMethod:(SEL)newSelector;

@end
