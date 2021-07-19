//
///  MDFDBStorage.h
///  GeiNiHua
//
///  Created by ChenYuan on 17/3/9.
///  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 线程安全

@interface MDFDBStorage : NSObject

- (instancetype)initWithNameSpace:(NSString *)nameSpace;

@property (nonatomic, copy, readonly) NSString *nameSpace;

/// 存储
- (BOOL)setObject:(id )object forKey:(NSString *)aKey error:(NSError **)error;

/// 移除
- (BOOL)removeObjectForKey:(NSString *)key error:(NSError **)error;

/// 取值
- (id)objectForKey:(NSString *)key error:(NSError **)error;

/// 是否存在内容
- (BOOL)isExistObjectForKey:(NSString *)key;

/// userInfo
- (BOOL)setUserInfo:(NSDictionary *)userInfo forKey:(NSString *)aKey error:(NSError **)error;

/// 获取字典
- (NSDictionary *)userInfoForKey:(NSString *)aKey error:(NSError **)error;

/// 清理命名空间
+ (void)cleanNameSpace:(NSString *)nameSpace;

/**
 * @param nameSpace : NSString 命名空间
 * @param fieldArray : NSArray 字段数组(eg:@[@{@"fieldName": @"messageId", @"fieldType": @"TEXT"}, @{@"fieldName": @"hasRead", @"fieldType": @"INTEGER"}];)
 **/

/// 创建命名空间
- (instancetype)initWithNameSpace:(NSString *)nameSpace fields:(NSArray *)fieldArray;

/**
 * @param keys : NSString 查找的key字符串，多个用逗号隔开(eg:flagId, hasRead)
 * @param conditionsKeys : NSString 条件key字符串，多个用逗号隔开(eg:address, time)
 * @param arguments : NSArray 参数 (keys/conditionKeys的所有参数组成的数组，"存储"中为两者参数，"查找"中为conditionKeys的参数)(eg:@[@(1), @(0), @"北京", @"2015-08-26"])
 * @param args : va_list 参数 (keys/conditionKeys的所有参数，"存储"中为两者参数，"查找"中为conditionKeys的参数)(eg:@(1), @(0), @"北京", @"2015-08-26")
 **/

/// 存储
- (BOOL)setObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys, ...;
- (BOOL)setObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments;
- (BOOL)setObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withVAList:(va_list)args;
- (BOOL)setObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments orVAList:(va_list)args;

/// 查找
- (id)objectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys, ...;
- (id)objectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments;
- (id)objectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withVAList:(va_list)args;
- (id)objectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments orVAList:(va_list)args;

/// 移除
- (BOOL)removeObjectForConditionKeys:(NSString *)conditionKeys, ...;
- (BOOL)removeObjectForConditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments;
- (BOOL)removeObjectForConditionKeys:(NSString *)conditionKeys withVAList:(va_list)args;
- (BOOL)removeObjectForConditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments orVAList:(va_list)args;

/// 是否存在
- (BOOL)isExistObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys, ...;
- (BOOL)isExistObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments;
- (BOOL)isExistObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withVAList:(va_list)args;
- (BOOL)isExistObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments orVAList:(va_list)args;

@end
