//
//  MDFSmallCache.h
//  GeiNiHua
//
//  Created by ChenYuan on 16/8/15.
//  Copyright © 2016年 GNH. All rights reserved.
//  缓存费时操作，由系统管理储存的资源

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "NSDate+String.h"

NS_ASSUME_NONNULL_BEGIN
typedef id _Nullable (^MDFSmallCacheFailToFind)(_Nullable Class cls, NSString * const key);

@interface MDFSmallCache : NSObject

singleton_interface(MDFSmallCache)

/**  缓存耗时数据
 *
 *  @param  key         在缓存中的标识
 *  @param  cls         缓存数据类型，根据cls检测获取的数据类型是否匹配，
 *  @param  failToFind  缓存中没有找到匹配的数据，将该回调返回数据进行缓存
 *
 *  @return 返回所需对象
 */
+ (nullable id)fetchObjcForKey:(NSString *)key
                       ofClass:(nullable Class)cls
                    failToFind:(MDFSmallCacheFailToFind)failToFind;

+ (void)setObjc:(id)objc forKey:(NSString * const)key;
+ (id)objcForKey:(NSString * const)key ofClass:(nullable Class)cls;
+ (void)removeObjcForKey:(NSString *const)key;

@end
NS_ASSUME_NONNULL_END

