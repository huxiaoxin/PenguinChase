//
//  NSDictionary+MDF.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSDictionary+MDF.h"
#import "NSString+Safe.h"

static NSString *const kSpacePlaceholder = @"   ";

static NSString *spacesWithNumber(int number) {
    NSMutableString *spaces = [[NSMutableString alloc] init];
    for (int i = 0; i < number; i++) {
        [spaces appendString:kSpacePlaceholder];
    }
    return [[NSString alloc] initWithString:spaces];
}

@implementation NSDictionary (MDF)

- (NSString *)mdf_urlEncodedKeyValueString
{

    NSMutableString *string = [NSMutableString string];
    for (NSString *key in self) {
        NSObject *value = [self valueForKey:key];
        if ([value isKindOfClass:[NSString class]])
            [string appendFormat:@"%@=%@&", key, ((NSString *)value)];
        else
            [string appendFormat:@"%@=%@&", key, value];
    }

    if ([string length] > 0)
        [string deleteCharactersInRange:NSMakeRange([string length] - 1, 1)];

    return string;
}

- (NSString *)mdf_jsonEncodedKeyValueString
{
    return [self mdf_jsonEncodedKeyValueStringOptions:0];
}

- (NSString *)mdf_jsonEncodedKeyValueStringOptions:(NSJSONWritingOptions)opt
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:opt
                                                     error:&error];
    if (error) {
        NSLog(@"JSON Parsing Error: %@", error);

        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)mdf_plistEncodedKeyValueString
{

    NSError *error = nil;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self
                                                              format:NSPropertyListXMLFormat_v1_0
                                                             options:0 error:&error];
    if (error) {
        NSLog(@"JSON Parsing Error: %@", error);

        return nil;
    }

    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)mdf_signWithKeyOrder
{
    NSArray *keys = [self allKeys];

    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult (id subKey1, id subKey2) {
        NSString *firstValue = subKey1;
        NSString *secondValue = subKey2;
        return [firstValue compare:secondValue];
    }];

    NSString *sign = @"";
    for (NSString *key in sortedKeys) {
        NSString *value = [self objectForKey:key];
        sign = [sign stringByAppendingFormat:@"%@|", value];
    }
    return sign;
}

- (NSString *)mdf_stringForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *) obj stringValue];
    }
    return nil;
}

- (NSNumber *)mdf_numberForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return @([obj doubleValue]);
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return obj;
    }
    return nil;
}

- (NSString *)mdf_httpRequestBody
{
    NSMutableString *requestBody = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [requestBody appendFormat:@"&%@=%@", key, obj];
    }];

    NSString *body = nil;
    if (requestBody.length > 1) {
        body = [requestBody mdf_safeSubstringFromIndex:1];
    }

    return body;
}

// 打印字典数据
- (NSString *)mdf_description {
    NSMutableString *readable = [[NSMutableString alloc] init];
    [NSDictionary mdf_printDict:self space:1 mutable:readable];
    return [[NSString alloc] initWithString:readable];
}

+ (void)mdf_printDict:(NSDictionary *)dict space:(int)spaceNumber mutable:(NSMutableString *)mutable {
    NSArray *keys = [dict allKeys];
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = (NSString *)obj;
        id value = [dict objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSMutableString *spaces = [[NSMutableString alloc] init];
            for (int i = 0; i < spaceNumber; i++) {
                [spaces appendString:kSpacePlaceholder];
            }
            
            [mutable appendString:[NSString stringWithFormat:@"\n%@%@ = { ", spaces, key]];
            [self mdf_printDict:value space:spaceNumber + 1 mutable:mutable];
            [mutable appendString:[NSString stringWithFormat:@"\n%@}", spaces]];
        } else if ([value isKindOfClass:[NSArray class]]) {
            NSMutableString *spaces = [[NSMutableString alloc] init];
            for (int i = 0; i < spaceNumber; i++) {
                [spaces appendString:kSpacePlaceholder];
            }
            
            [mutable appendString:[NSString stringWithFormat:@"\n%@%@ = (", spaces, key]];
            
            int  newSpaceNumber = spaceNumber + 2;
            for (int i = 0; i < ((NSArray *)value).count; i++) {
                if ([(value)[i] isKindOfClass:[NSDictionary class]]) {
                    [mutable appendString:@"\n"];
                    [mutable appendString:spacesWithNumber(newSpaceNumber)];
                    [mutable appendString:@"{"];
                    
                    [self mdf_printDict:value[i] space:newSpaceNumber + 1 mutable:mutable];
                    
                    [mutable appendString:@"\n"];
                    [mutable appendString:spacesWithNumber(newSpaceNumber)];
                    
                    if (i == ((NSArray *)value).count - 1) {
                        [mutable appendString:@"}"];
                    } else {
                        [mutable appendString:@"},"];
                    }
                } else if ([value[i] isKindOfClass:[NSNumber class]]) {
                    [mutable appendString:spacesWithNumber(newSpaceNumber)];
                    [mutable appendString:[NSString stringWithFormat:@"%lf", [(NSNumber *)value[i] floatValue]]];
                    [mutable appendString:@";"];
                    [mutable appendString:@"\n"];
                } else if ([value[i] isKindOfClass:[NSString class]]) {
                    [mutable appendString:spacesWithNumber(newSpaceNumber)];
                    [mutable appendString:value[i]];
                    [mutable appendString:@";"];
                    [mutable appendString:@"\n"];
                }
            }
            [mutable appendString:[NSString stringWithFormat:@"\n%@)", spaces]];
        } else {
            [mutable appendString:spacesWithNumber(spaceNumber)];
            NSString *line = [NSString stringWithFormat:@"\n%@%@ = %@;", spacesWithNumber(spaceNumber), key, value];
            [mutable appendString:line];
        }
    }];
}

@end



