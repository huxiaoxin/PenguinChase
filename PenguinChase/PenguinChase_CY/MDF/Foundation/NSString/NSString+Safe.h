//
//  NSString+Safe.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, StringTruncatingType)
{
    StringTruncatingTypeHead = 1, // 头部加...
    StringTruncatingTypeMiddle,   // 中间加...
    StringTruncatingTypeTail      // 尾部加...
};

@interface NSString (Safe)

- (unichar)mdf_safeCharacterAtIndex:(NSUInteger)index;

- (NSString *)mdf_safeSubstringToIndex:(NSUInteger)index;

- (NSString *)mdf_safeSubstringFromIndex:(NSUInteger)index;

- (NSString *)mdf_safeSubstringWithRange:(NSRange)range;

+ (NSString *)mdf_unEmptyStringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

- (BOOL)mdf_containsString:(NSString *)string;

- (NSString *)mdf_safeSubstringWithMaxLength:(NSUInteger)maxLength stringTruncatingType:(StringTruncatingType)stringTruncatingType;

- (NSComparisonResult)mdf_safeLocalizedCompare:(NSString *)string;

@end
