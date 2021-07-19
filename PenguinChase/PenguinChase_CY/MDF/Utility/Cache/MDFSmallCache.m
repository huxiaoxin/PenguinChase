//
//  MDFSmallCache.m
//  GeiNiHua
//
//  Created by ChenYuan on 2017/5/17.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFSmallCache.h"

@interface MDFSmallCache ()
@property (nonatomic, strong) NSCache *cache;
@end
@implementation MDFSmallCache
singleton_implementation(MDFSmallCache)

+ (void)setObjc:(id)objc forKey:(NSString *)key {
    [[MDFSmallCache sharedMDFSmallCache].cache setObject:objc forKey:key];
}

- (NSCache *)cache {
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = 1000;
    }
    return _cache;
}

+ (id)objcForKey:(NSString *)key ofClass:(nullable Class)cls{
    id objc = [[MDFSmallCache sharedMDFSmallCache].cache objectForKey:key];
    if (cls != nil) {
        if ([objc isKindOfClass:cls]) {
        } else {
            objc ? [self removeObjcForKey:key] : nil;
            objc = nil;
        }
    } else {
    }
    return objc;
}

+ (id)fetchObjcForKey:(NSString *)key
              ofClass:(Class)cls
           failToFind:(MDFSmallCacheFailToFind)failToFind {
    id objc = [MDFSmallCache objcForKey:key ofClass:cls];
    if (!objc && failToFind) {
        objc = failToFind(cls, key);
        if (objc) {
            [MDFSmallCache setObjc:objc forKey:key];
        } else {
            [MDFSmallCache removeObjcForKey:key];
        }
    }
    return objc;
}

+ (void)removeObjcForKey:(NSString *const)key {
    [[MDFSmallCache sharedMDFSmallCache].cache removeObjectForKey:key];
}

@end

