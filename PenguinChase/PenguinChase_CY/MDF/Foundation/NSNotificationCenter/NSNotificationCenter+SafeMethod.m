//
//  NSNotificationCenter+SafeMethod.m
//  JDBClient
//
//  Created by jinzhanxie on 14/12/31.
//  Copyright (c) 2014年 JDB. All rights reserved.
//

#import "NSNotificationCenter+SafeMethod.h"

@implementation NSNotificationCenter (SafeMethod)

- (void)mdf_safeAddObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    [self removeObserver:observer name:aName object:anObject];
    [self addObserver:observer selector:aSelector name:aName object:anObject];
}

@end
