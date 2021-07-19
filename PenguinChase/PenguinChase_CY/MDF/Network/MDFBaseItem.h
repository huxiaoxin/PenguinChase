//
//  MDFBaseItem.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFAutoSerializationItem.h"

@protocol MDFBaseItemUnAutoParseProperty <NSObject>
@end

@interface NSObject ()<MDFBaseItemUnAutoParseProperty>
@end

@interface MDFBaseItem : MDFAutoSerializationItem

- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary;

+ (NSArray *)arrayWithJSONObject:(id)JSONObject;

//设置json用于自动解析
- (void)parseJSONValue:(NSDictionary *)jsonValue;

//如果子类中的元素有数组类型的话，通过重载这个方法返回解析后数组元素类型
//默认是返回nil
- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName;
//通过属性名称相对应返回Json串中的key，默认与属性名称一样
- (NSString *)JSONKeyForProperty:(NSString *)propertyKey;
//解析结束回调
- (void)afterAutoParse;
//要开始解析
- (void)willAutoParse;
// 根据一个对象赋值
- (void)setValueWithItem:(MDFBaseItem *)item;

@end
