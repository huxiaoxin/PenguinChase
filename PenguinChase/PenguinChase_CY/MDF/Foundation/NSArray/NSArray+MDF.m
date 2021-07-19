//
//  NSArray+MDF.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSArray+MDF.h"
#import "MDFConfigue.h"

@implementation NSArray (MDF)

- (id)mdf_safeObjectAtIndex:(NSUInteger)index
{
#if EnableSafeContainer
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
#else
    return [self objectAtIndex:index];
#endif
}

- (id)mdf_safeSubarrayWithRange:(NSRange)range
{
#if EnableSafeContainer
    if (range.location + range.length <= self.count) {
        return [self subarrayWithRange:range];
    }
    return nil;
#else
    return [self subarrayWithRange:range];
#endif
}

- (NSString*)mdf_jsonValue {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0 // non-pretty printing
                                                     error:&error];
    if(error)
        NSLog(@"JSON Parsing Error: %@", error);
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
