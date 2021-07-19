//
//  MDFDBStorageItem.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFDBStorageItem.h"

@implementation MDFDBFieldInfo

@end

@implementation MDFDBStorageItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"storageFields"]) {
        return [MDFDBFieldInfo class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end
