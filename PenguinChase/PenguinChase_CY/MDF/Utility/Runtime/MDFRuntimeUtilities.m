//
//  MDFRuntimeUtilities.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFRuntimeUtilities.h"
#import "NSMutableDictionary+MDF.h"

@implementation MDFRuntimeUtilities

+ (NSDictionary *)propertiesForClass:(Class)cls
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [self propertyName:property];
        NSString *propertyType = [self propertyTypeName:property];
        if (propertyName && propertyType){
            [dict mdf_safeSetObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    return dict;
}

+ (NSString *)propertyName:(objc_property_t)property
{
    const char *propName = property_getName(property);
    if (propName) {
        return [[NSString alloc] initWithCString:propName encoding:NSASCIIStringEncoding];
    }
    return nil;
}

+ (NSString *)propertyTypeName:(objc_property_t)property
{
    char *propertyType = property_copyAttributeValue(property, "T");
    
    if (!propertyType) {
        return nil;
    }
    
    NSString *clsName = nil;
    if (propertyType[0] == '@') {
        if (propertyType[1] == '\0') {
            clsName = NSStringFromClass([NSObject class]);
        }
        else {
            long stringLength = strlen(propertyType);
            if (stringLength > 3) {
                //去除@"
                char *classString = propertyType + 2;
                stringLength -= 2;
                //去除"
                classString[stringLength-1] = '\0';
                
                clsName = [[NSString alloc] initWithCString:classString encoding:NSASCIIStringEncoding];
            }
        }
    }
    else{
        clsName = [[NSString alloc] initWithCString:propertyType encoding:NSASCIIStringEncoding];
    }
    
    free(propertyType);
    return clsName;
}

+ (BOOL)property:(objc_property_t)property hasPropertyType:(char *)encoding {
    char *attribute = property_copyAttributeValue(property, encoding);
    BOOL hasEncoding = attribute != NULL;
    free(attribute);
    return hasEncoding;
}

+ (BOOL)propertyIsObject:(objc_property_t)property {
    char *attribute = property_copyAttributeValue(property, "T");
    BOOL isObject = attribute[0] == '@';
    free(attribute);
    return isObject;
}

+ (BOOL)propertyIsWeak:(objc_property_t)property {
    return [self property:property hasPropertyType:"W"];
}

+ (BOOL)propertyIsStrong:(objc_property_t)property {
    return [self property:property hasPropertyType:"&"];
}

+ (BOOL)propertyIsCopy:(objc_property_t)property {
    return [self property:property hasPropertyType:"C"];
}

+ (BOOL)propertyIsReadOnly:(objc_property_t)property {
    return [self property:property hasPropertyType:"R"];
}

+ (BOOL)propertyIsAssign:(objc_property_t)property {
    // There is no specific encoding for this.
    // We assume it's assign if its an object, and isn't retain or strong
    BOOL isWeak = [self propertyIsWeak:property];
    BOOL isObject = [self propertyIsObject:property];
    BOOL isStrongOrCopy = [self propertyIsStrong:property] || [self propertyIsCopy:property];
    return  isObject && !isWeak && !isStrongOrCopy;
}

@end
