//
//  MDFDBStorageItem.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFBaseItem.h"

@interface MDFDBFieldInfo : MDFBaseItem

@property (nonatomic, copy) NSString *fieldName; // 字段名
@property (nonatomic, copy) NSString *fieldType; // 字段类型，若有约束带约束

@end

@interface MDFDBStorageItem : MDFBaseItem

@property (nonatomic, strong) NSArray *storageFields;

@end
