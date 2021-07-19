//
//  NSObject+SwizzMethod.m
//  反欺诈埋点model
//
//  Created by tanxk on 2017/10/18.
//  Copyright © 2017年 51信用卡. All rights reserved.
//

#import "NSObject+SwizzMethod.h"
#import <objc/runtime.h>

@implementation NSObject (SwizzMethod)
/// 交换两个方法的实现
+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
