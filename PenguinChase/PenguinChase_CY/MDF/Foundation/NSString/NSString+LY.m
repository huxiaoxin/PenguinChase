//
//  NSString+LY.m
//  shuaidanbao
//
//  Created by ChenYuan on 15/9/11.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

#import "NSString+LY.h"
#import <UIKit/UIKit.h>


#define IdentityCardRegex @"^[1-9]\\d{5}[1-9]\\d{3}(0\\d|1[0-2])([0-2]\\d|3[0-1])\\d{3}(\\d|x|X)$" //身份证
#define EmailRegex    @"^[A-Z\\da-z._%+-]+@[A-Za-z\\d.-]+\\.[A-Za-z]{2,4}$" //邮箱
#define PostcodeRegex @"^\\d{6}$" //邮编
#define ChineseRegex  @"^[\u4e00-\u9fa5]+$" //中文
#define PhoneNoRegex  @"^(1(([3578][0-9])|(47)))\\d{8}$" //手机号

@implementation NSString (LY)

#pragma mark - 字符串处理
- (NSString *)replaceStringSymbol:(NSString *)symbol {
    NSString *string = [symbol repeatStringNumber:self.length];
    return string;
}

- (NSString *)repeatStringNumber:(NSUInteger)number {
    if (number <= 0) {
        return nil;
    }
    NSString *string = @"";
    for (NSUInteger i = 0; i < number; i++) {
        string = [self stringByAppendingString:string];
    }
    return string;
}

- (NSString *)replaceStringSymbol:(NSString *)symbol range:(NSRange)range {
    NSString *string = nil;
    if (range.location == NSNotFound || range.location >= self.length || range.length <= 0) {
        string = self;
    }else {
        if ((range.length + range.location) > self.length) {//超出范围重置 范围
            range = NSMakeRange(range.location, self.length - range.location);
        }
        NSString *tmpString = [symbol repeatStringNumber:range.length];
        if (tmpString) {
            string = [self stringByReplacingCharactersInRange:range withString:tmpString];
        }else {
            string = self;
        }
    }
    return string;
}

#pragma mark - 获取GB/MB/KB/B
+ (NSString *)fileSizeToString:(unsigned long long)fileSize {
    NSInteger KB = 1024;
    NSInteger MB = pow(KB, 2);
    NSInteger GB = pow(KB, 3);
    
    if (fileSize < 10) {
        return @"0 B";
    }else if (fileSize < KB) {
        return [NSString stringWithFormat:@"%.1f B", (CGFloat)fileSize];
    }else if (fileSize < MB) {
        return [NSString stringWithFormat:@"%.1f KB", ((CGFloat)fileSize) / KB];
    }else if (fileSize < GB) {
        return [NSString stringWithFormat:@"%.1f MB", ((CGFloat)fileSize) / MB];
    }else {
        return [NSString stringWithFormat:@"%.1f GB", ((CGFloat)fileSize) / GB];
    }
}

#pragma mark - 格式化数字
+ (NSString *)getFormatForNum:(NSNumber *)num count:(NSInteger)count separator:(NSString *)separator flag:(BOOL)flag {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.usesGroupingSeparator = YES;
    formatter.groupingSize = count;
    formatter.groupingSeparator = separator;
    if (flag) {
        formatter.numberStyle = kCFNumberFormatterRoundFloor; //保留小数位
    }
    return [formatter stringFromNumber:num];
}

+ (NSString *)getFormatForNum:(NSNumber *)num count:(NSInteger)count separator:(NSString *)separator {
    return [self getFormatForNum:num count:count separator:separator flag:NO];
}

#pragma mark - jsonDic转换
+ (NSDictionary *)jsonDicTransFromStr:(NSString *)dataStr {
    if (dataStr == nil) {
        return nil;
    }
    
    NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return [NSString funcClearNull:dic];;
}
+ (id)funcClearNull:(id)objectData {
    
    if ([objectData isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)objectData count]];
        for (id value in (NSArray *)objectData) {
            [mutableArray addObject:[NSString funcClearNull:value]];
        }
        
        return mutableArray;
    } else if ([objectData isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:objectData];
        for (id <NSCopying> key in [(NSDictionary *)objectData allKeys]) {
            id value = (NSDictionary *)objectData[key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDic removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                mutableDic[key] = [NSString funcClearNull:value];
            }
        }
        return mutableDic;
    }
    
    return objectData;
}

#pragma mark - 验证信息
- (BOOL)checkShenFenZheng {
    NSString *tempStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; //去掉两端的空格
    if (18 != tempStr.length) {
        return NO;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IdentityCardRegex];
    BOOL isMatch = [pred evaluateWithObject:tempStr];

    return isMatch;
}

- (BOOL)checkEmail {
    if (self.length == 0) {
        return NO;
    }
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",EmailRegex];
    if (![emailTest evaluateWithObject:self])  {
        return NO;
    }
    return YES;
}

- (BOOL)checkPostcode {
    if (6 != self.length) {
        return NO;
    }
    NSPredicate *prdicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PostcodeRegex];
    return [prdicate evaluateWithObject:self];
}

/** 校验银行卡卡号 */
- (BOOL)checkBankCard {
    // 验证数字：^[0-9]*$
    if (0 == self.length) {
        return NO;
    }
    NSString *regex  = @"^[0-9]{16,19}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if(![pred evaluateWithObject:self]) {
        return NO;
    }
    char bit = [self getBankCardCheckCode:[self substringWithRange:NSMakeRange(0, self.length - 1)]];
    
    return bit == [self characterAtIndex:self.length - 1];
}

/** 从不含校验位的银行卡卡号采用 Luhm 校验算法获得校验位 */
- (char)getBankCardCheckCode:(NSString *)nonCheckCodeCardId {
    // 验证数字：^[0-9]*$
    NSString *regex  = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if(nonCheckCodeCardId.length == 0||![pred evaluateWithObject:nonCheckCodeCardId]) {
        return '#';
    }
    const char *chs = [nonCheckCodeCardId UTF8String];
    int luhmSum = 0;
    for(int i = (int)(nonCheckCodeCardId.length - 1), j = 0; i >= 0; i--, j++) {
        int k = chs[i] - '0';
        if(j % 2 == 0) {
            k *= 2;
            k = k / 10 + k % 10;
        }
        luhmSum += k;
    }
    char res = (luhmSum % 10 == 0) ? '0' : (char)((10 - luhmSum % 10) + '0');
    return res;
    
}

- (BOOL)checkMobile {
    if (self.length == 0) {
        return NO;
    }

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PhoneNoRegex];
    return [pred evaluateWithObject:self];
}

- (BOOL)checkChinese {
    if (0 == self.length) {
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ChineseRegex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)containsString:(NSString *)str  {
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    NSRange range = [self rangeOfString:str];
    if (range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

@end
