//
//  NSNotificationCenter+SafeMethod.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (SafeMethod)

// 安全添加观察者
- (void)mdf_safeAddObserver:(id)observer
                   selector:(SEL)aSelector
                       name:(NSString *)aName
                     object:(id)anObject;

@end
