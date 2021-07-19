//
//  NSMutableArray+MDF.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MDF)

- (void)mdf_safeAddObject:(nonnull id)obj;

- (void)mdf_safeAddObjectsFromArray:(nonnull NSArray *)otherArray;

- (void)mdf_safeInsertObject:(nonnull id)obj atIndex:(NSUInteger)index;

- (void)mdf_safeInsertObjects:(nonnull NSArray *)objects atIndexes:(nonnull NSIndexSet *)indexes;

- (void)mdf_safeRemoveLastObject;

- (void)mdf_safeRemoveObject:(nonnull id)anObject inRange:(NSRange)aRange;

- (void)mdf_safeRemoveObjectAtIndex:(NSUInteger)index;

- (void)mdf_safeRemoveObjectIdenticalTo:(nonnull id)anObject inRange:(NSRange)aRange;

- (void)mdf_safeRemoveObjectsAtIndexes:(nonnull NSIndexSet *)indexes;

- (void)mdf_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(nonnull id)anObject;

- (void)mdf_safeReplaceObjectsAtIndexes:(nonnull NSIndexSet *)indexes withObjects:(nonnull NSArray *)objects;

- (void)mdf_safeSetObject:(nonnull id)anObject atIndexedSubscript:(NSUInteger)index;

- (void)mdf_safeRemoveObject:(nonnull id)anObject;

@end
