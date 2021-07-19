//
//  NSObject+Cache.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSObject+Cache.h"
#import "MDFCache.h"

@implementation NSObject (Cache)

+ (id)objectFromCacheByKey:(NSString *)akey
{
    if (!akey.length) {
        return nil;
    }
    id obj = [[MDFCache sharedCache] objectForKey:[self nameSpaceKeyWithOriginalKey:akey]];
    return obj;
}

+ (void)setCacheObject:(id<NSCoding>)obj forKey:(NSString *)akey
{
    if (!akey.length || !obj) {
        return;
    }
    [[MDFCache sharedCache] setObject:obj forKey:[self nameSpaceKeyWithOriginalKey:akey]];
}

+ (void)removeCacheByKey:(NSString *)akey
{
    if (!akey.length) {
        return;
    }
    [[MDFCache sharedCache] removeObjectForKey:[self nameSpaceKeyWithOriginalKey:akey]];
}

+ (NSString *)nameSpaceKeyWithOriginalKey:(NSString *)akey
{
    if (!akey.length) {
        return nil;
    }
    return [NSString stringWithFormat:@"%@.%@.%@", [self namespaceForCache], NSStringFromClass(self), akey];
}

+ (NSString *)namespaceForCache
{
    return @"Cache_Public";
}

@end
