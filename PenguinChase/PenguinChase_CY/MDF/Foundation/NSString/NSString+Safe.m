//
//  NSString+Safe.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSString+Safe.h"
#import "MDFConfigue.h"

@implementation NSString (Safe)

- (unichar)mdf_safeCharacterAtIndex:(NSUInteger)index
{
#if EnableSafeContainer
    if (index >= self.length) {
        return '\0';
    }
    return [self characterAtIndex:index];
#else
    return [self characterAtIndex:index];
#endif
}

- (NSString *)mdf_safeSubstringToIndex:(NSUInteger)index
{
#if EnableSafeContainer
    if(index > self.length) {
        return nil;
    }
    return [self substringToIndex:index];
#else
    return [self substringToIndex:index];
#endif
}

- (NSString *)mdf_safeSubstringFromIndex:(NSUInteger)index
{
#if EnableSafeContainer
    if(index > self.length) {
        return nil;
    }
    return [self substringFromIndex:index];
#else
    return [self substringFromIndex:index];
#endif
}

- (NSString *)mdf_safeSubstringWithRange:(NSRange)range
{
#if EnableSafeContainer
    if(range.location == NSNotFound) {
        return nil;
    }
    return [self substringWithRange:range];
#else
    return [self substringWithRange:range];
#endif
}

+ (NSString *)mdf_unEmptyStringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    if (!format) {
        nil;
    }
    
    va_list args;
    va_start(args, format);
    NSString *resultString = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
#if EnableSafeContainer
    resultString = [resultString stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    return resultString;
#else
    return resultString;
#endif
}

- (BOOL)mdf_containsString:(NSString *)string
{
    if(string) {
        if ([self respondsToSelector:@selector(containsString:)]) {
            return ([self containsString:string]);
        } else if ([self respondsToSelector:@selector(rangeOfString:)]) {
            return ([self rangeOfString:string].location != NSNotFound);
        }
    }
    return NO;
}

- (NSString *)mdf_safeSubstringWithMaxLength:(NSUInteger)maxLength stringTruncatingType:(StringTruncatingType)stringTruncatingType
{
#if EnableSafeContainer
    if (!self) {
        return nil;
    }
    return [self mdf_substringWithMaxLength:maxLength stringTruncatingType:stringTruncatingType];
#else
    return [self mdf_substringWithMaxLength:maxLength stringTruncatingType:stringTruncatingType];
#endif
}

- (NSString *)mdf_substringWithMaxLength:(NSUInteger)maxLength stringTruncatingType:(StringTruncatingType)stringTruncatingType
{
    NSString *truncatedString = self;
    if (stringTruncatingType < 1 || stringTruncatingType > 3) {
        stringTruncatingType = StringTruncatingTypeTail;
    }
    
    switch (stringTruncatingType) {
        case StringTruncatingTypeHead: {
            if (self.length > maxLength) {
                NSString *subString = [self mdf_safeSubstringToIndex:maxLength];
                if (subString.length > 0) {
                    truncatedString = [NSString stringWithFormat:@"...%@", subString];
                }
            }
            break;
        }
        case StringTruncatingTypeMiddle: {
            if (self.length > maxLength) {
                NSString *subString = [self mdf_safeSubstringToIndex:maxLength];
                if (subString.length > 0) {
                    NSUInteger middleIndex = [subString length] / 2;
                    NSString *preSubString = [subString mdf_safeSubstringToIndex:middleIndex];
                    NSString *lastSubString = [subString mdf_safeSubstringFromIndex:middleIndex];
                    if (preSubString.length && lastSubString.length) {
                        truncatedString = [NSString stringWithFormat:@"%@...%@", preSubString, lastSubString];
                    }
                }
            }
            break;
        }
        case StringTruncatingTypeTail: {
            if (self.length > maxLength) {
                NSString *subString = [self mdf_safeSubstringToIndex:maxLength];
                if (subString.length > 0) {
                    truncatedString = [NSString stringWithFormat:@"%@...", subString];
                }
            }
            break;
        }
        default:
            break;
    }
    
    return truncatedString;
}

- (NSComparisonResult)mdf_safeLocalizedCompare:(NSString *)string;
{
#if EnableSafeContainer
    if (!self) {
        return NSOrderedAscending; // 如果本身是nil的话，就认为是小于
    }
    
    if (!string) {
        return NSOrderedDescending; // 如果string是nil的话，就认为是大于
    }
    
    return [self localizedCompare:string];
#else
    return [self localizedCompare:string];
#endif
}

@end
