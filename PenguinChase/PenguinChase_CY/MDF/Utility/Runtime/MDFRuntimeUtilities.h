//
//  MDFRuntimeUtilities.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface MDFRuntimeUtilities : NSObject

+ (NSDictionary *)propertiesForClass:(Class)cls;

+ (NSString *)propertyTypeName:(objc_property_t)property;

+ (BOOL)propertyIsObject:(objc_property_t)property;

+ (BOOL)propertyIsWeak:(objc_property_t)property;

+ (BOOL)propertyIsStrong:(objc_property_t)property;

+ (BOOL)propertyIsCopy:(objc_property_t)property;

+ (BOOL)propertyIsAssign:(objc_property_t)property;

+ (BOOL)propertyIsReadOnly:(objc_property_t)property;

@end
