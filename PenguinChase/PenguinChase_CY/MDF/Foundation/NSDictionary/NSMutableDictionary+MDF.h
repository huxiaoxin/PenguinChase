//
//  NSMutableDictionary+MDF.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableDictionary<KeyType, ObjectType> (Safe)

- (void)mdf_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)mdf_safeSetObject:(id)object forKeyedSubscript:(id<NSCopying>)aKey;

- (void)mdf_safeRemoveObjectForKey:(id)aKey;

- (void)mdf_safeRemoveObjectsForKeys:(NSArray<KeyType> *)keyArray;

@end
