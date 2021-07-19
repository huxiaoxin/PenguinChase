//
//  MDFSingletonManager.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFSingletonManager.h"
#import "MDFSingleton.h"
#import "MDFSingletonSerialProxy.h"

@interface MDFSingletonManager ()
{
    NSMutableDictionary *sharedInstanceDictionary;
    NSRecursiveLock *singletonLock;
}

@end


@implementation MDFSingletonManager

- (id)init
{
    self = [super init];
    if (self) {
        sharedInstanceDictionary = [[NSMutableDictionary alloc] init];
        singletonLock = [[NSRecursiveLock alloc] init];
    }
    
    return self;
}

+ (MDFSingletonManager*)sharedManager
{
    static MDFSingletonManager *factory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        factory = [[MDFSingletonManager alloc] init];
    });
    
    return factory;
}

- (id)copyWithZone:(NSZone*)zone
{
    return self;
}

- (id)sharedInstanceFor:(Class)aClass
{
    NSString *key = NSStringFromClass(aClass);
    
    [self->singletonLock lock];
    
    id obj = nil;
    if (key) {
        obj = [self->sharedInstanceDictionary objectForKey:key];
        if (!obj) {
            obj = [[aClass alloc] init];
            if (obj && [aClass isSubclassOfClass:[MDFSingleton class]]) {
                if ([((MDFSingleton *)obj) needsSerialProxy]) {
                    obj = [MDFSingletonSerialProxy singletonSerialProxy:obj];
                }
                [self->sharedInstanceDictionary setObject:obj forKey:key];
            }
        }
    }
    [self->singletonLock unlock];
    
    return obj;
}

- (id)sharedInstanceFor:(Class)aClass category:(NSString *)key
{
    NSString *className = NSStringFromClass(aClass);
    NSString *classKey = [NSString stringWithFormat:@"%@-%@",className,key];
    
    [self->singletonLock lock];
    
    id obj = nil;
    if (classKey) {
        obj = [self->sharedInstanceDictionary objectForKey:classKey];
        if (!obj) {
            obj = [[aClass alloc] init];
            [self->sharedInstanceDictionary setObject:obj forKey:classKey];
        }
    }
    [self->singletonLock unlock];
    
    return obj;
}

- (void)destroySharedInstanceFor:(Class)aClass
{
    NSString *key = NSStringFromClass(aClass);
    
    [self->singletonLock lock];
    
    id obj = nil;
    if (key) {
        obj = [self->sharedInstanceDictionary objectForKey:key];
        if (obj) {
            [self->sharedInstanceDictionary removeObjectForKey:key];
        }
    }
    [self->singletonLock unlock];
}

- (void)destroySharedInstanceFor:(Class)aClass category:(NSString*)key
{
    NSString *className = NSStringFromClass(aClass);
    NSString *classKey = [NSString stringWithFormat:@"%@-%@",className,key];
    
    [self->singletonLock lock];
    
    id obj = nil;
    if (classKey) {
        obj = [self->sharedInstanceDictionary objectForKey:classKey];
        if (obj) {
            [self->sharedInstanceDictionary removeObjectForKey:classKey];
        }
    }
    [self->singletonLock unlock];
}

@end

