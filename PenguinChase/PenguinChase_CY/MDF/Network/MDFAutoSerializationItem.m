//
//  MDFAutoSerializationItem.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFAutoSerializationItem.h"
#import <objc/runtime.h>
#import "MDFRuntimeUtilities.h"
#import "NSString+Utility.h"
#import "NSMutableDictionary+MDF.h"
#import "NSArray+MDF.h"

static NSString * const kUnSerializationProperty = @"MDFUnSerializationProperty";

@implementation MDFAutoSerializationItem

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init])
    {
        unsigned int propertyCount = 0;
        Class cls = self.class;
        
        while (cls != [NSObject class]) {
            objc_property_t *propertyList = class_copyPropertyList(cls, &propertyCount);
            for (unsigned i = 0; i < propertyCount; i++) {
                objc_property_t property = propertyList[i];
                const char *attrs = property_getAttributes(property);
                NSString* propertyAttributes = @(attrs);
                //不需要序列化的属性
                if (![propertyAttributes mdf_contains:kUnSerializationProperty]) {
                    NSArray* attributeItems = [propertyAttributes componentsSeparatedByString:@","];
                    if ([attributeItems containsObject:@"R"]) {
                        continue;
                    }
                    NSString * propertyName= [NSString stringWithUTF8String:property_getName(property)];
                    @try {
                        if (propertyName.length) {
                            id value = [aDecoder decodeObjectForKey:propertyName];
                            if (value && propertyName.length) {
                                [self setValue:value forKey:propertyName];
                            }
                        }
                    }@catch (NSException *exception) {
                        
                    }
                }
            }
            free(propertyList);
            propertyCount = 0;
            propertyList = NULL;
            cls = class_getSuperclass(cls);
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int propertyCount = 0;
    Class cls = self.class;
    
    while (cls != [NSObject class]) {
        objc_property_t *propertyList = class_copyPropertyList(cls, &propertyCount);
        for (unsigned i = 0; i < propertyCount; i++) {
            objc_property_t property = propertyList[i];
            const char *attrs = property_getAttributes(property);
            NSString* propertyAttributes = @(attrs);
            if (![propertyAttributes mdf_contains:kUnSerializationProperty]) {
                NSArray* attributeItems = [propertyAttributes componentsSeparatedByString:@","];
                if ([attributeItems containsObject:@"R"]) {
                    continue;
                }
                NSString * propertyName= [NSString stringWithUTF8String:property_getName(property)];
                @try {
                    id value = [self valueForKey:propertyName];
                    if (value && propertyName.length && [value conformsToProtocol:@protocol(NSCoding)]) {
                        [aCoder encodeObject:value forKey:propertyName];
                    }
                }@catch (NSException *exception) {
                    
                }
            }
        }
        free(propertyList);
        cls = class_getSuperclass(cls);
        propertyList = NULL;
        propertyCount = 0;
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    MDFAutoSerializationItem *item = [[self class] allocWithZone:zone];
    unsigned int propertyCount = 0;
    
    Class cls = self.class;
    while(cls != [NSObject class])
    {
        objc_property_t *propertyList = class_copyPropertyList(cls, &propertyCount);
        for (unsigned i = 0; i < propertyCount; i++) {
            objc_property_t property = propertyList[i];
            if ([MDFRuntimeUtilities propertyIsReadOnly:property]) {
                continue;
            }
            NSString * propertyName= [NSString stringWithUTF8String:property_getName(property)];
            @try {
                id value = [self valueForKey:propertyName];
                if (value && propertyName.length) {
                    [item setValue:value forKey:propertyName];
                }
            } @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
        }
        free(propertyList);
        cls = class_getSuperclass(cls);
        propertyList = NULL;
        propertyCount = 0;
    }
    
    return item;
}

//获取属性字典
- (NSDictionary *)propertyToDictionaryWithClass:(Class)classObj
{
    uint count = 0;
    objc_property_t *propertyList = class_copyPropertyList(classObj, &count);
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithCapacity:count];
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = propertyList[i];
        const char *pName = property_getName(property);
        if (pName){
            id value = [self valueForKey:[NSString stringWithUTF8String:pName]];
            if (value){
                if ([value isKindOfClass:[MDFAutoSerializationItem class]]){
                    NSDictionary *valueDic = [value propertyToDictionary];
                    [properties mdf_safeSetObject:valueDic forKey:[NSString stringWithUTF8String:pName]];
                }
                else if ([value isKindOfClass:[NSArray class]]){
                    NSArray *valueArr = (NSArray *)value;
                    NSString *arrayType = [MDFRuntimeUtilities propertyTypeName:property];
                    if ([arrayType rangeOfString:@"MDFPropertyToDictionaryArrayToJson"].location == NSNotFound) {
                        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                        for (MDFAutoSerializationItem *item in valueArr){
                            if ([item isKindOfClass:[MDFAutoSerializationItem class]]){
                                NSDictionary *tempDic =  [item propertyToDictionary];
                                if (tempDic){
                                    [tempArray addObject:tempDic];
                                }
                            }
                            else {
                                [tempArray addObject:item];
                            }
                        }
                        [properties mdf_safeSetObject:tempArray forKey:[NSString stringWithUTF8String:pName]];
                    } else {
                        [properties mdf_safeSetObject:[valueArr mdf_jsonValue] forKey:[NSString stringWithUTF8String:pName]];
                    }
                }
                else{
                    [properties mdf_safeSetObject:value forKey:[NSString stringWithUTF8String:pName]];
                }
            }
        }
    }
    
    free(propertyList);
    propertyList = nil;
    
    return properties;
}

- (NSDictionary *)propertyToDictionary
{
    return [self propertyToDictionaryWithClass:[self class]];
}

@end
