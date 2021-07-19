#import "TMCache.h"

NSString * const TMCachePrefix = @"com.jiuding.TMCache";
NSString * const TMCacheSharedName = @"TMCacheShared";

@interface TMCache ()
#if OS_OBJECT_USE_OBJC
@property (strong, nonatomic) dispatch_queue_t queue;
#else
@property (assign, nonatomic) dispatch_queue_t queue;
#endif
@end

@implementation TMCache

#pragma mark - Initialization -

#if !OS_OBJECT_USE_OBJC
- (void)dealloc
{
    dispatch_release(_queue);
    _queue = nil;
}
#endif

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name rootPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
}

- (instancetype)initWithName:(NSString *)name rootPath:(NSString *)rootPath
{
    if (!name)
        return nil;

    if (self = [super init]) {
        _name = [name copy];
        
        NSString *queueName = [[NSString alloc] initWithFormat:@"%@.%p", TMCachePrefix, self];
        _queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_CONCURRENT);

        _diskCache = [[TMDiskCache alloc] initWithName:_name rootPath:rootPath];
        _memoryCache = [[TMMemoryCache alloc] init];
    }
    return self;
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%@.%@.%p", TMCachePrefix, _name, self];
}

#pragma mark - Public Asynchronous Methods -

- (void)memoryObjectForKey:(NSString *)key block:(TMCacheObjectBlock)block
{
    if (!key || !block)
        return;
    
    __weak TMCache *weakSelf = self;
    
    dispatch_async(_queue, ^{
        TMCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        __weak TMCache *weakSelf = strongSelf;
        
        [strongSelf->_memoryCache objectForKey:key block:^(TMMemoryCache *cache, NSString *key, id object) {
            TMCache *strongSelf = weakSelf;
            if (!strongSelf)
                return;
            dispatch_async(strongSelf->_queue, ^{
                TMCache *strongSelf = weakSelf;
                if (strongSelf)
                    block(strongSelf, key, object);
            });
        }];
    });
         
}

- (void)objectForKey:(NSString *)key block:(TMCacheObjectBlock)block
{
    if (!key || !block)
        return;

    __weak TMCache *weakSelf = self;

    dispatch_async(_queue, ^{
        TMCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        __weak TMCache *weakSelf = strongSelf;
        
        [strongSelf->_memoryCache objectForKey:key block:^(TMMemoryCache *cache, NSString *key, id object) {
            TMCache *strongSelf = weakSelf;
            if (!strongSelf)
                return;
            
            if (object) {
                [strongSelf->_diskCache fileURLForKey:key block:^(TMDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
                    // update the access time on disk
                }];

                __weak TMCache *weakSelf = strongSelf;
                
                dispatch_async(strongSelf->_queue, ^{
                    TMCache *strongSelf = weakSelf;
                    if (strongSelf)
                        block(strongSelf, key, object);
                });
            } else {
                __weak TMCache *weakSelf = strongSelf;

                [strongSelf->_diskCache objectForKey:key block:^(TMDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
                    TMCache *strongSelf = weakSelf;
                    if (!strongSelf)
                        return;
                    
                    // add by xiejinzhan
                    NSUInteger cost = 0;
                    if (strongSelf->_costBlock) {
                        cost = strongSelf->_costBlock(strongSelf,key,object);
                    }
                    // ----
                    
                    [strongSelf->_memoryCache setObject:object forKey:key withCost:cost block:nil];
                    
                    __weak TMCache *weakSelf = strongSelf;
                    
                    dispatch_async(strongSelf->_queue, ^{
                        TMCache *strongSelf = weakSelf;
                        if (strongSelf)
                            block(strongSelf, key, object);
                    });
                }];
            }
        }];
    });
}

- (void)setObjectToMemory:(id <NSCoding>)object forKey:(NSString *)key block:(TMCacheObjectBlock)block
{
    [self setObjectToMemory:object forKey:key withCost:0 block:block];
}

- (void)setObjectToMemory:(id <NSCoding>)object forKey:(NSString *)key withCost:(NSUInteger)cost block:(TMCacheObjectBlock)block
{
    if (!key || !object)
        return;
    
    dispatch_async(_queue, ^{
        __weak typeof(self) weakSelf = self;
        [self->_memoryCache setObject:object forKey:key withCost:cost block:^(TMMemoryCache *cache, NSString *key, id object) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (block) {
                block(strongSelf, key, object);
            }
        }];
    });
}

- (void)setObjectToDisk:(id)object forKey:(NSString *)key block:(TMCacheObjectBlock)block
{
    if (!key || !object)
        return;
    
    dispatch_async(_queue, ^{
        __weak typeof(self) weakSelf = self;
        [self->_diskCache setObject:object forKey:key block:^(TMDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (block) {
                block(strongSelf, key, object);
            }
        }];
    });
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key withCost:(NSUInteger)cost block:(TMCacheObjectBlock)block
{
    if (!key || !object)
        return;
    
    dispatch_group_t group = nil;
    TMMemoryCacheObjectBlock memBlock = nil;
    TMDiskCacheObjectBlock diskBlock = nil;
    
    if (block) {
        group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        
        memBlock = ^(TMMemoryCache *cache, NSString *key, id object) {
            dispatch_group_leave(group);
        };
        
        diskBlock = ^(TMDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
            dispatch_group_leave(group);
        };
    }
    
    [_memoryCache setObject:object forKey:key withCost:cost block:memBlock];
    [_diskCache setObject:object forKey:key block:diskBlock];
    
    if (group) {
        __weak TMCache *weakSelf = self;
        dispatch_group_notify(group, _queue, ^{
            TMCache *strongSelf = weakSelf;
            if (strongSelf)
                block(strongSelf, key, object);
        });
        
#if !OS_OBJECT_USE_OBJC
        dispatch_release(group);
#endif
    }
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key block:(TMCacheObjectBlock)block
{
    [self setObject:object forKey:key withCost:0 block:block];
}

- (void)removeObjectForKey:(NSString *)key block:(TMCacheObjectBlock)block
{
    if (!key)
        return;
    
    dispatch_group_t group = nil;
    TMMemoryCacheObjectBlock memBlock = nil;
    TMDiskCacheObjectBlock diskBlock = nil;
    
    if (block) {
        group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        
        memBlock = ^(TMMemoryCache *cache, NSString *key, id object) {
            dispatch_group_leave(group);
        };
        
        diskBlock = ^(TMDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
            dispatch_group_leave(group);
        };
    }

    [_memoryCache removeObjectForKey:key block:memBlock];
    [_diskCache removeObjectForKey:key block:diskBlock];
    
    if (group) {
        __weak TMCache *weakSelf = self;
        dispatch_group_notify(group, _queue, ^{
            TMCache *strongSelf = weakSelf;
            if (strongSelf)
                block(strongSelf, key, nil);
        });
        
        #if !OS_OBJECT_USE_OBJC
        dispatch_release(group);
        #endif
    }
}

- (void)removeAllObjects:(TMCacheBlock)block
{
    dispatch_group_t group = nil;
    TMMemoryCacheBlock memBlock = nil;
    TMDiskCacheBlock diskBlock = nil;
    
    if (block) {
        group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        
        memBlock = ^(TMMemoryCache *cache) {
            dispatch_group_leave(group);
        };
        
        diskBlock = ^(TMDiskCache *cache) {
            dispatch_group_leave(group);
        };
    }
    
    [_memoryCache removeAllObjects:memBlock];
    [_diskCache removeAllObjects:diskBlock];
    
    if (group) {
        __weak TMCache *weakSelf = self;
        dispatch_group_notify(group, _queue, ^{
            TMCache *strongSelf = weakSelf;
            if (strongSelf)
                block(strongSelf);
        });
        
        #if !OS_OBJECT_USE_OBJC
        dispatch_release(group);
        #endif
    }
}

- (void)trimToDate:(NSDate *)date block:(TMCacheBlock)block
{
    if (!date)
        return;

    dispatch_group_t group = nil;
    TMMemoryCacheBlock memBlock = nil;
    TMDiskCacheBlock diskBlock = nil;
    
    if (block) {
        group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        
        memBlock = ^(TMMemoryCache *cache) {
            dispatch_group_leave(group);
        };
        
        diskBlock = ^(TMDiskCache *cache) {
            dispatch_group_leave(group);
        };
    }
    
    [_memoryCache trimToDate:date block:memBlock];
    [_diskCache trimToDate:date block:diskBlock];
    
    if (group) {
        __weak TMCache *weakSelf = self;
        dispatch_group_notify(group, _queue, ^{
            TMCache *strongSelf = weakSelf;
            if (strongSelf)
                block(strongSelf);
        });
        
        #if !OS_OBJECT_USE_OBJC
        dispatch_release(group);
        #endif
    }
}

#pragma mark - Public Synchronous Accessors -

- (NSUInteger)diskByteCount
{
    __block NSUInteger byteCount = 0;
    
    dispatch_sync([TMDiskCache sharedQueue], ^{
        byteCount = self.diskCache.byteCount;
    });
    
    return byteCount;
}

#pragma mark - Public Synchronous Methods -

- (id)memoryObjectForKey:(NSString *)key
{
    if (!key) {
        return nil;
    }
    
    __block id objectForKey = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self memoryObjectForKey:key block:^(TMCache *cache, NSString *key, id object) {
        objectForKey = object;
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
#if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
#endif
    
    return objectForKey;

}

- (BOOL)memoryExistObjectForKey:(NSString *)key
{
    return ([self memoryObjectForKey:key] != nil);
}

- (void)memoryExistObjectForKey:(NSString *)key block:(TMCacheExistObjectBlock )block
{
    [self memoryObjectForKey:key block:^(TMCache *cache, NSString *key, id object) {
        if (block) {
            block(cache,(object != nil));
        }
    }];
}

- (BOOL)diskExistObjectForKey:(NSString *)key
{
    if (!key)
        return NO;
    
    __block BOOL objectForKey = NO;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self diskExistObjectForKey:key block:^(TMCache *cache, BOOL exist) {
        objectForKey = exist;
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
#if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
#endif
    
    return objectForKey;
}

- (void)diskExistObjectForKey:(NSString *)key block:(TMCacheExistObjectBlock )block
{
    if (!key) {
        if (block) {
            dispatch_async(self->_queue, ^{
                block(self,NO);
            });
        }
        return;
    }
    
    __weak TMCache *weakSelf = self;
    dispatch_async(self->_queue, ^{
        TMCache *strongSelf = weakSelf;
        if (!strongSelf){
            return ;
        }
        
        __weak TMCache *weakSelf = strongSelf;
        
        [strongSelf->_diskCache existObjectForKey:key block:^(TMDiskCache *cache, BOOL exist) {
            TMCache *strongSelf = weakSelf;
            if (!strongSelf){
                return ;
            }
            
            __weak TMCache *weakSelf = strongSelf;
            if (block) {
                dispatch_async(strongSelf->_queue, ^{
                    TMCache *strongSelf = weakSelf;
                    if (strongSelf) {
                        block(strongSelf,exist);
                    } else {
                        block(strongSelf,NO);
                    }
                });
            }
        }];
    });
}

- (id)objectForKey:(NSString *)key
{
    if (!key)
        return nil;
    
    __block id objectForKey = nil;

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self objectForKey:key block:^(TMCache *cache, NSString *key, id object) {
        objectForKey = object;
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif

    return objectForKey;
}

- (void)setObjectToMemory:(id)object forKey:(NSString *)key
{
    if (!object || !key) {
        return;
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self setObjectToMemory:object forKey:key block:^(TMCache *cache, NSString *key, id object) {
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
#if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
#endif
}

- (void)setObjectToDisk:(id )object forKey:(NSString *)key
{
    if (!object || !key) {
        return;
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self setObjectToDisk:object forKey:key block:^(TMCache *cache, NSString *key, id object) {
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
#if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
#endif
}

- (void)setObjectToMemory:(id)object forKey:(NSString *)key withCost:(NSUInteger)cost
{
    if (!object || !key) {
        return;
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self setObjectToMemory:object forKey:key withCost:cost block:^(TMCache *cache, NSString *key, id object) {
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
#if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
#endif
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key withCost:(NSUInteger)cost
{
    if (!object || !key)
        return;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self setObject:object forKey:key withCost:cost block:^(TMCache *cache, NSString *key, id object) {
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
#if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
#endif
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key
{
    [self setObject:object forKey:key withCost:0];
}

- (void)removeObjectForKey:(NSString *)key
{
    if (!key)
        return;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self removeObjectForKey:key block:^(TMCache *cache, NSString *key, id object) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)trimToDate:(NSDate *)date
{
    if (!date)
        return;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self trimToDate:date block:^(TMCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)removeAllObjects
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self removeAllObjects:^(TMCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

@end

// HC SVNT DRACONES
