//
//  NSObject+PTLSwizzle.m
//  PTLDatasource
//
//  Created by Brian Partridge on 8/30/13.
//
//

#import "NSObject+PTLSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (PTLSwizzle)

+ (BOOL)ptl_swizzleMethod:(SEL)originalSelector withMethod:(SEL)newSelector {
   Method originalMethod = class_getInstanceMethod(self, originalSelector);
   if (originalMethod == NULL) {
      NSLog(@"Error: Unable to obtain method implementation for original method '%@' on '%@'", NSStringFromSelector(originalSelector), NSStringFromClass(self));
      return NO;
   }

   Method newMethod = class_getInstanceMethod(self, newSelector);
   if (newMethod == NULL) {
      NSLog(@"Error: Unable to obtain method implementation for swizzled method '%@' on '%@'", NSStringFromSelector(newSelector), NSStringFromClass(self));
      return NO;
   }

   class_addMethod(self, originalSelector, class_getMethodImplementation(self, originalSelector), method_getTypeEncoding(originalMethod));
   class_addMethod(self, newSelector, class_getMethodImplementation(self, newSelector), method_getTypeEncoding(newMethod));

   method_exchangeImplementations(class_getInstanceMethod(self, originalSelector), class_getInstanceMethod(self, newSelector));

   return YES;
}

+ (BOOL)ptl_swizzleClassMethod:(SEL)originalSelector withClassMethod:(SEL)newSelector {
   return [object_getClass(self) ptl_swizzleMethod:originalSelector withMethod:newSelector];
}

@end
