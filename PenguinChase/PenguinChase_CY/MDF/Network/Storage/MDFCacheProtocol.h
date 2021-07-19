//
//  MDFCacheProtocol.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MDFCacheProtocol <NSObject>

/**  从缓存中取对应key的obj
 *  @param akey 对应缓存的key
 *  @return 返回对应key的缓存
 */
+ (id)objectFromCacheByKey:(NSString *)akey;

/**  缓存obj
 *  @param obj  要缓存的数据
 *  @param akey 对应缓存的key
 */
+ (void)setCacheObject:(id<NSCoding>)obj forKey:(NSString *)akey;

/**  移除对应的缓存
 *  @param akey 对应缓存的key
 */
+ (void)removeCacheByKey:(NSString *)akey;

/**  命名空间下对应缓存的key
 *  @param akey 对应缓存的key
 *  @return 返回命名空间下对应缓存的key
 */
+ (NSString *)nameSpaceKeyWithOriginalKey:(NSString *)akey;

/**  命名空间
 *  @return 返回命名空间
 */
+ (NSString *)namespaceForCache;

@end
