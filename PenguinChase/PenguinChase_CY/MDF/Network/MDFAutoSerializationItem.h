//
//  MDFAutoSerializationItem.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MDFUnSerializationProperty <NSObject>
@end

@protocol MDFPropertyToDictionaryArrayToJson <NSObject>
@end

@interface NSArray ()<MDFPropertyToDictionaryArrayToJson>
@end

@interface NSObject ()<MDFUnSerializationProperty>
@end

@interface MDFAutoSerializationItem : NSObject <NSCopying, NSCoding>

//获取属性字典
- (NSDictionary *)propertyToDictionary;
- (NSDictionary *)propertyToDictionaryWithClass:(Class)classObj;

@end
