//
//  NSMutableDictionary+MDF.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSMutableDictionary+MDF.h"
#import "MDFConfigue.h"

@implementation NSMutableDictionary (Safe)

- (void)mdf_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
#if EnableSafeContainer
    if (!anObject || !aKey) {
        return ;
    }
    [self setObject:anObject forKey:aKey];
#else
    [self setObject:anObject forKey:aKey];
#endif
}

- (void)mdf_safeSetObject:(id)object forKeyedSubscript:(id<NSCopying>)aKey
{
#if EnableSafeContainer
    if (!object || !aKey) {
        return ;
    }
    [self setObject:object forKeyedSubscript:aKey];
#else
    [self setObject:object forKeyedSubscript:aKey];
#endif
}

- (void)mdf_safeRemoveObjectForKey:(id)aKey
{
#if EnableSafeContainer
    if(!aKey) {
        return;
    }
    [self removeObjectForKey:aKey];
#else
    [self removeObjectForKey:aKey];
#endif
}

- (void)mdf_safeRemoveObjectsForKeys:(NSArray *)keyArray
{
#if EnableSafeContainer
    if(!keyArray) {
        return;
    }
    [self removeObjectsForKeys:keyArray];
#else
    [self removeObjectsForKeys:keyArray];
#endif
}


@end
