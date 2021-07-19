//
//  MDFBaseItem.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFBaseItem.h"
#import "MDFRuntimeUtilities.h"

static NSArray *cTypes = nil;

@implementation MDFBaseItem

+ (void)load
{
    cTypes = @[@"i",@"s",@"l",@"q",@"I",@"S",@"L",@"Q",@"f",@"d",@"b",@"c",@"B"];
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self parseJSONValue:dictionary];
    }
    return self;
}

- (NSString *)JSONKeyForProperty:(NSString *)propertyKey
{
    return propertyKey;
}

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    return nil;
}

- (void)parseJSONValue:(NSDictionary *)jsonValue
{
    if (jsonValue && [jsonValue isKindOfClass:[NSDictionary class]]){
        __strong NSDictionary *dicForJsonValue = jsonValue;
        [self willAutoParse];
        Class cls = [self class];
        while (cls != [MDFBaseItem class]) {
            NSDictionary *propertyList = [MDFRuntimeUtilities propertiesForClass:cls];
            
            for (NSString *key in [propertyList allKeys])
            {
                //属性类型
                NSString *typeString = [propertyList objectForKey:key];
                //根据属性获取jsonkey
                NSString* jsonKey = [self JSONKeyForProperty:key];
                //json中的值
                id jsonKeyMapValue = [dicForJsonValue objectForKey:jsonKey];
                
                if (jsonKeyMapValue && typeString && jsonKey)
                {
                    [self _setJSONValue:jsonKeyMapValue propertyCls:typeString propertyName:key];
                }
            }
            
            cls = [cls superclass];
        }
        [self afterAutoParse];
    }
    else{
        NSLog(@"can not support un NSDictionary Class in MDFBaseItem");
    }
}

+ (NSArray *)arrayWithJSONArray:(NSArray *)JSONArray modelClass:(Class)modelClass
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (id JSONObject in JSONArray) {
        if ([JSONObject isKindOfClass:[NSDictionary class]] && [modelClass isSubclassOfClass:[MDFBaseItem class]]) {
            MDFBaseItem *baseItem = [[modelClass alloc] initWithJSONDictionary:JSONObject];
            [array addObject:baseItem];
        } else if ([JSONObject isKindOfClass:[NSArray class]]) {
            NSArray *parsedArray = [self arrayWithJSONArray:JSONObject modelClass:modelClass];
            [array addObject:parsedArray];
        } else {
            [array addObject:JSONObject];
        }
    }
    return array;
}

+ (NSArray *)arrayWithJSONObject:(id)JSONObject
{
    if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        return [[self alloc] initWithJSONDictionary:JSONObject];
    } else if ([JSONObject isKindOfClass:[NSArray class]]) {
        return [self arrayWithJSONArray:JSONObject modelClass:[self class]];
    } else {
        return nil;
    }
}

- (void)_setJSONValue:(id)jsonValue propertyCls:(NSString *)className propertyName:(NSString *)propertyName
{
    if (jsonValue && className && propertyName) {
        
        if ([className rangeOfString:@"MDFBaseItemUnAutoParseProperty"].location != NSNotFound) {
            return;
        }
        
        Class propertyCls = NSClassFromString(className);
        
        id value = nil;
        
        if ([propertyCls isSubclassOfClass:[MDFBaseItem class]]) //嵌套
        {
            if ([jsonValue isKindOfClass:[NSDictionary class]]) {
                MDFBaseItem *baseItem = [[propertyCls alloc] init];
                [baseItem parseJSONValue:jsonValue];
                value = baseItem;
            }
        }
        else if ([propertyCls isSubclassOfClass:[NSArray class]]){ //如果是数组
            //jsonvalue是一个数组
            if ([jsonValue isKindOfClass:[NSArray class]]) {
                
                value = [NSMutableArray arrayWithCapacity:[jsonValue count]];
                //遍历jsonvalue中数组
                for (id arrayElement in jsonValue) {
                    //取出数据中的对象类型
                    if ([arrayElement isKindOfClass:[NSNull class]]) {
                        continue;
                    }
                
                    id elementValue = arrayElement;
                    Class objectClass = [self classForObject:arrayElement inArrayWithPropertyName:propertyName];
                
                    if ([arrayElement isKindOfClass:[NSArray class]]) {
                        elementValue = [[self class] arrayWithJSONArray:arrayElement modelClass:objectClass];
                    } else if ([arrayElement isKindOfClass:[NSDictionary class]]) {
                        //如果数组元素类型是个字典，而且objectClass是MDFBaseItem子类
                        if (objectClass && [objectClass isSubclassOfClass:[MDFBaseItem class]]) {
                            MDFBaseItem *baseItem = [[objectClass alloc] init];
                            [baseItem parseJSONValue:arrayElement];
                            elementValue = baseItem;
                        }
                    }
                    [value addObject:elementValue];
                }
            }
        }
        else if ([propertyCls isSubclassOfClass:[NSString class]]){
            if ([jsonValue isKindOfClass:[NSString class]]){
                value = jsonValue;
            }
            else if ([jsonValue isKindOfClass:[NSNumber class]]){
                value = [(NSNumber *)jsonValue stringValue];
            }
        }
        else if ([propertyCls isSubclassOfClass:[NSNumber class]]){
            if ([jsonValue isKindOfClass:[NSString class]]){
                value = @([(NSString *)jsonValue doubleValue]);
            }
            else if ([jsonValue isKindOfClass:[NSNumber class]]){
                value = jsonValue;
            }
        }
        else if ([propertyCls isSubclassOfClass:[NSDictionary class]]){
            if ([jsonValue isKindOfClass:[NSDictionary class]]){
                value = jsonValue;
            }
        }
        else{
            //C语言类型
            if ([cTypes containsObject:className]) {
                if ([jsonValue isKindOfClass:[NSString class]]) {
                    value = @([((NSString *)jsonValue) doubleValue]);
                }
                else if ([jsonValue isKindOfClass:[NSNumber class]]){
                    value = jsonValue;
                }
                else{
                    value = @(0);
                }
            }
        }
        
        [self _setValue:value forKey:propertyName];
    }
}

- (void)_setValue:(id)value forKey:(NSString *)key
{
#ifdef DEBUG
    [self setValue:value forKey:key];
#else
    @try {
        [self setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        NSLog(@"0x1, exception in MDFBaseItem");
    }
#endif
}


- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"class:%@ ---- key:%@不遵循KVC", NSStringFromClass([self class]),key);
}

- (void)setNilValueForKey:(NSString *)key
{
    NSLog(@"class:%@ ---- key:%@是值类型不能赋值为nil", NSStringFromClass([self class]), key);
}

- (id)valueForUndefinedKey:(NSString *)key
{
    NSLog(@"class:%@ ---- key:%@不存在", NSStringFromClass([self class]), key);
    return nil;
}

- (void)setValueWithItem:(MDFBaseItem *)item
{
    if (![item isKindOfClass:[MDFBaseItem class]]) {
        return;
    }
    Class cls = [item class];
    while (cls != [MDFBaseItem class]) {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(cls, &outCount);
        for(i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSASCIIStringEncoding];
            id value = [item valueForKey:propertyName];
            id validateValue = value;
            if (value && [self validateValue:&validateValue forKey:propertyName error:nil] &&
                [self respondsToSelector:NSSelectorFromString(propertyName)]) {
                [self _setValue:validateValue forKey:propertyName];
            }
        }
        free(properties);
        cls = [cls superclass];
    }
}

- (void)afterAutoParse{}
- (void)willAutoParse{}

@end
