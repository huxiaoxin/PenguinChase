//
//  NSMutableArray+MDF.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSMutableArray+MDF.h"
#import "MDFConfigue.h"

@implementation NSMutableArray (MDF)

- (void)mdf_safeAddObject:(nonnull id)obj
{
#if EnableSafeContainer
    if (obj) {
        [self addObject:obj];
    }
#else
    [self addObject:obj];
#endif
}

- (void)mdf_safeAddObjectsFromArray:(nonnull NSArray *)otherArray
{
#if EnableSafeContainer
    if (otherArray) {
        [self addObjectsFromArray:otherArray];
    }
#else
    [self addObjectsFromArray:otherArray];
#endif
}

- (void)mdf_safeInsertObject:(nonnull id)obj atIndex:(NSUInteger)index
{
#if EnableSafeContainer
    if (obj) {
        if (index < self.count) {
            [self insertObject:obj atIndex:index];
        } else if(index == self.count) {
            [self addObject:obj];
        }
    }
#else
    [self insertObject:obj atIndex:index];
#endif
}

- (void)mdf_safeInsertObjects:(nonnull NSArray *)objects atIndexes:(nonnull NSIndexSet *)indexes
{
#if EnableSafeContainer
    if (objects && indexes) {
        [self insertObjects:objects atIndexes:indexes];
    }
#else
    [self insertObjects:objects atIndexes:indexes];
#endif
}

- (void)mdf_safeRemoveLastObject
{
#if EnableSafeContainer
    if (self.count > 0) {
        [self removeLastObject];
    }
#else
    [self removeLastObject];
#endif
}

- (void)mdf_safeRemoveObject:(nonnull id)anObject inRange:(NSRange)aRange
{
#if EnableSafeContainer
    if (anObject && (aRange.location + aRange.length) <= self.count) {
        [self removeObject:anObject inRange:aRange];
    }
#else
    [self removeObject:anObject inRange:aRange];
#endif
}
- (void)mdf_safeRemoveObjectAtIndex:(NSUInteger)index
{
#if EnableSafeContainer
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
#else
    [self removeObjectAtIndex:index];
#endif
}

- (void)mdf_safeRemoveObjectIdenticalTo:(nonnull id)anObject inRange:(NSRange)aRange
{
#if EnableSafeContainer
    if (anObject && (aRange.location + aRange.length) <= self.count) {
        [self removeObjectIdenticalTo:anObject inRange:aRange];
    }
#else
    [self removeObjectIdenticalTo:anObject inRange:aRange];
#endif
}
- (void)mdf_safeRemoveObjectsAtIndexes:(nonnull NSIndexSet *)indexes
{
#if EnableSafeContainer
    __block BOOL outOfRange = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > self.count - 1) {
            outOfRange = YES;
            *stop = YES;
        }
    }];
    if (indexes && !outOfRange) {
        [self removeObjectsAtIndexes:indexes];
    }
#else
    [self removeObjectsAtIndexes:indexes];
#endif
}
- (void)mdf_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(nonnull id)anObject
{
#if EnableSafeContainer
    if (index < self.count && anObject) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
#else
    [self replaceObjectAtIndex:index withObject:anObject];
#endif
}

- (void)mdf_safeReplaceObjectsAtIndexes:(nonnull NSIndexSet *)indexes withObjects:(nonnull NSArray *)objects
{
#if EnableSafeContainer
    if (indexes && objects && indexes.count == objects.count ) {
        [self replaceObjectsAtIndexes:indexes withObjects:objects];
    }
#else
    [self replaceObjectsAtIndexes:indexes withObjects:objects];
#endif
}

- (void)mdf_safeSetObject:(nonnull id)anObject atIndexedSubscript:(NSUInteger)index
{
#if EnableSafeContainer
    if (anObject && index <= self.count) {
        [self setObject:anObject atIndexedSubscript:index];
    }
#else
    [self setObject:anObject atIndexedSubscript:index];
#endif
}

- (void)mdf_safeRemoveObject:(nonnull id)anObject
{
#if EnableSafeContainer
    if (anObject && [self containsObject:anObject]) {
        [self removeObject:anObject];
    }
#else
    [self removeObject:anObject];
#endif
}

@end
