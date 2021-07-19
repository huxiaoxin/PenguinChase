//
//  MDFCache.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFCache.h"

NSString *const shareCacheName = @"sharecahce";
NSString *const shareImageCacheName = @"shareimagecahce";

static NSTimeInterval const MDFCacheDefaultAgeLimitSeconds = 3 * 24 * 60 * 60;

@implementation MDFCache

- (instancetype)initWithName:(NSString *)name
{
    self = [super initWithName:name];
    if (self) {
        self.diskCache.ageLimit = MDFCacheDefaultAgeLimitSeconds;
    }
    return self;
}

+ (instancetype)sharedCache
{
    static MDFCache *cache = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        cache = [[self alloc] initWithName:shareCacheName];
    });
    
    return cache;
}

+ (instancetype)sharedImageCache
{
    static MDFCache *cache = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        cache = [[self alloc] initWithName:shareImageCacheName];
        
    });
    
    return cache;
}

@end
