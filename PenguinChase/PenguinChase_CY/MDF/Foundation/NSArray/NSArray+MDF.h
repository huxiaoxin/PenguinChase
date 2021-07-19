//
//  NSArray+MDF.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSArray (MDF)

//安全
- (id)mdf_safeObjectAtIndex:(NSUInteger)index;
- (id)mdf_safeSubarrayWithRange:(NSRange)range;

// 数组转换为json
- (NSString *)mdf_jsonValue;

@end
