//
//  NSString+Utility.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSString+Utility.h"
#import "NSArray+MDF.h"
#import "NSString+Safe.h"
#import "NSMutableArray+MDF.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSMutableDictionary+MDF.h"

#pragma mark - sring
extern NSString *unemptyString(NSString *orgString, NSString *replacementString)
{
    if (orgString.length) {
        return orgString;
    }
    return replacementString.length ? replacementString : @"";
}

extern NSString *unemptyStringByDefault(NSString *orgString)
{
    if (orgString.length) {
        return orgString;
    }
    return @"";
}

extern id unnullObjectDyDefault(id obj)
{
    if (obj) {
        return obj;
    }
    
    return @"";
}

BOOL doubleEquals(double a, double b)
{
    return (fabs(a - b) < 0.000001);
}

#pragma mark - NSString
@implementation NSString (Utility)

- (id)mdf_jsonValue
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([data length] > 0) {
        NSError *serializationError = nil;
        id jsonValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&serializationError];
        return serializationError ? nil : jsonValue;
    } else {
        return nil;
    }
}

- (NSDictionary *)mdf_jsonValueToDictionary
{
    id jsonValue = [self mdf_jsonValue];
    if ([jsonValue isKindOfClass:[NSDictionary class]]) {
        return jsonValue;
    } else {
        return nil;
    }
}

- (NSArray *)mdf_jsonValueToArray
{
    id jsonValue = [self mdf_jsonValue];
    if ([jsonValue isKindOfClass:[NSArray class]]) {
        return jsonValue;
    } else {
        return nil;
    }
}

- (NSString *)mdf_jsonValueToString
{
    id jsonValue = [self mdf_jsonValue];
    if ([jsonValue isKindOfClass:[NSString class]]) {
        return jsonValue;
    } else {
        return nil;
    }
}

- (NSString *)mdf_stringByTrimingWhitespaceOrNewlineCharacter
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)mdf_stringByTrimingAllWhitespaces
{
    NSString *noWhiteSpaceString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    noWhiteSpaceString = [noWhiteSpaceString stringByReplacingOccurrencesOfString:@"\u00a0" withString:@""];
    return noWhiteSpaceString;
}

- (NSUInteger)mdf_numberOfLines
{
    return [[self componentsSeparatedByString:@"\n"] count] + 1;
}

- (BOOL)mdf_isPureInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    scan.charactersToBeSkipped = nil;
    int val;
    return ([scan scanInt:&val] && [scan isAtEnd]);
}

- (BOOL)mdf_isPureFloat
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    scan.charactersToBeSkipped = nil;
    float val;
    return ([scan scanFloat:&val] && [scan isAtEnd]);
}

- (BOOL)mdf_isValidatedEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//用户名
- (BOOL)mdf_isValidatedUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]{1,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}

//密码
- (BOOL)mdf_isValidatedPassword
{
    NSString *regex = @"^\\w+$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regextestcm evaluateWithObject:self];
//
//    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
//    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
//    return [passWordPredicate evaluateWithObject:self];
}

//昵称
- (BOOL)mdf_isValidatedNickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

// 中文姓名
- (BOOL)mdf_isChineseName {
    NSString *regexName = @"[\u4e00-\u9fa5\\·\\.]{2,20}";
    NSPredicate *regextestName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexName];
    return [regextestName evaluateWithObject:self];
}

- (NSString *)mdf_chineseOrAbroadName {
    NSString *str = self;
    if (str.length) {
        NSString *regexStr = @"[a-zA-Z0-9\u4E00-\u9FA5\\.\\·]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
        if (![predicate evaluateWithObject:str]) {
            NSString *regexStr = @"[^a-zA-Z0-9\u4E00-\u9FA5\\.\\·]";
            //过滤中文、数字、字母、.、·
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:NULL];
            str = [regex stringByReplacingMatchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length) withTemplate:@""];
        }
    }
    return str;
}

//身份证号
- (BOOL)mdf_isValidatedIdentityCard
{
    NSString *IDCardNo = self;
    if (IDCardNo == nil || IDCardNo == NULL) {
        return NO;
    }
    
    if (IDCardNo.length !=18 && IDCardNo.length !=15) {
        return NO;
    }
    
    if (IDCardNo.length == 15) {
        NSString *v1IDCardNumberPattern = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
        NSPredicate *regextestName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", v1IDCardNumberPattern];
        return [regextestName evaluateWithObject:self];
    }
    
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[IDCardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[IDCardNo mdf_safeSubstringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString:[[IDCardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return NO;
}

// 座机号
- (BOOL)mdf_isValidatedTelLandline {
    NSString *phone = self;
    if ([self mdf_containsString:@"-"]) {
        phone = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    NSString *regexName = @"^(400|0(10|2[0-5789]|\\d{3}))\\d{6,22}$";
    NSPredicate *regextestName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexName];
    NSLog(@"%d", [regextestName evaluateWithObject:phone]);
    return [regextestName evaluateWithObject:phone];
}

// 手机号
- (BOOL)mdf_isValidatedMobile {
    NSString * phoneNum = unemptyStringByDefault(self);
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"+86 " withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString * MOBILE = @"^1(3|4|5|6|7|8|9)\\d{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:phoneNum];
}

- (NSString *)mdf_trimExtraDot
{
    if (!self.length) {
        return self;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"."];
    NSInteger intNumber = [[array mdf_safeObjectAtIndex:0] integerValue];
    NSString *floatNumber = [array mdf_safeObjectAtIndex:1];
    if (!floatNumber) {
        return self;
    } else {
        NSString *display = [NSNumberFormatter localizedStringFromNumber:@(intNumber)
                                                             numberStyle:NSNumberFormatterDecimalStyle];
        if ([floatNumber integerValue] == 0) {
            return display;
        } else {
            return [NSString stringWithFormat:@"%@.%@",display, floatNumber];
        }
    }
}

//是否包含
- (BOOL)mdf_contains:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

- (NSRange)mdf_containsAndRange:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    
    return range;
}

- (NSString *)mdf_fileName
{
    NSString *lastPath = [self lastPathComponent];
    lastPath = [lastPath stringByReplacingOccurrencesOfString:@"" withString:@"/"];
    if ([lastPath pathExtension].length > 0) {
        return [[lastPath componentsSeparatedByString:@"."] firstObject];
    }
    return lastPath;
}

- (NSString *)mdf_md5
{
    if (!self) {
        return nil;
    }
    const char *cStr = [self UTF8String];//转换成utf-8
    unsigned char result[CC_MD5_DIGEST_LENGTH];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5( cStr, (CC_LONG)(strlen(cStr)), result );
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    NSString* s = [NSString stringWithFormat:
                   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                   result[0], result[1], result[2], result[3],
                   result[4], result[5], result[6], result[7],
                   result[8], result[9], result[10], result[11],
                   result[12], result[13], result[14], result[15]
                   ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return s;
}

- (NSString *)mdf_formatPhoneNumber
{
    if (self.length != 11) {
        return self;
    }
    
    NSMutableString *format = [NSMutableString string];
    [format appendString:[self substringWithRange:NSMakeRange(0, 3)]];
    [format appendString:@" "];
    [format appendString:[self substringWithRange:NSMakeRange(3, 4)]];
    [format appendString:@" "];
    [format appendString:[self substringWithRange:NSMakeRange(7, 4)]];
    return [NSString stringWithString:format];
}

// 去除手机号中的异常字符
- (NSString *)mdf_purePhoneNumber {
    NSString *numberStr = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    numberStr = [numberStr mdf_stringByTrimingAllWhitespaces];
    numberStr = [numberStr stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    numberStr = [numberStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    numberStr = [numberStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    return numberStr;
}

#pragma mark - 检验空字符串 return YES 为空
+ (BOOL)mdf_isEmptyString:(NSString *)aString {
    
    if (aString == nil || aString == NULL) {
        return YES;
    } else if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([unemptyStringByDefault(aString) length] < 1) {
        return YES;
    } else if ([[unemptyStringByDefault(aString) mdf_stringByTrimingWhitespaceOrNewlineCharacter] length]==0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)mdf_formatIdentification
{
    NSMutableString *format = [NSMutableString string];
    for (NSUInteger i = 0; i < self.length; i++) {
        [format appendString:[self substringWithRange:NSMakeRange(i, 1)]];
        if (i == 2 || i == 5 || i == 9 || i == 13) {
            [format appendString:@" "];
        }
    }
    return [NSString stringWithString:format];
}

- (NSString *)mdf_formatBankCardNumber
{
    NSString *cardNumbStr = self;
    cardNumbStr = cardNumbStr.mdf_stringByTrimingAllWhitespaces; //去除空格
    
    NSMutableString *format = [NSMutableString string];

    for (NSUInteger i = 0; i < cardNumbStr.length; i += 4) {
        if ((i + 4) < cardNumbStr.length) {
            [format appendString:[cardNumbStr substringWithRange:NSMakeRange(i, 4)]];
            [format appendString:@" "];
        } else {
            [format appendString:[cardNumbStr substringWithRange:NSMakeRange(i, cardNumbStr.length - i)]];
        }
    }
    return [NSString stringWithString:format];
}

- (NSString *)mdf_formatCardIDNumber
{
    NSMutableArray *idCardArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.length; i++) {
        int asciiCode = [self characterAtIndex:i];
        NSString *charStr = [NSString stringWithFormat:@"%c", asciiCode];
        if (i == 2 || i == 5 || i == 9 || i == 13) {
            [idCardArray mdf_safeAddObject:[NSString stringWithFormat:@"%@ ", charStr]];
        } else {
            [idCardArray mdf_safeAddObject:charStr];
        }
    }
    
    return [idCardArray componentsJoinedByString:@""];
}

- (BOOL)mdf_containsChinese
{
    for (NSUInteger i = 0; i < self.length; i++) {
        if (((int)[self mdf_safeCharacterAtIndex:i]) > 127) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)mdf_containsEmoji
{
    __block BOOL result = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring mdf_isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}

- (BOOL)mdf_isEmoji
{
    const unichar hs = [self characterAtIndex:0];
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                return YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            return YES;
        }
    } else {
        if (0x2100 <= hs && hs <= 0x27ff) {
            return YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            return YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            return YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            return YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)mdf_isPureChinese
{
    BOOL ret = YES;
    for (NSUInteger i = 0; i < self.length; i++) {
        if (((int)[self mdf_safeCharacterAtIndex:i]) <= 127) {
            ret = NO;
            break;
        }
    }
    return ret;
}

- (NSDictionary *)mdf_httpRequestBodyDict
{
    if (!self.length) {
        return nil;
    }
    NSArray *objects = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (objects.count > 0) {
        [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *str = (NSString *)obj;
            NSArray *value = [str componentsSeparatedByString:@"="];
            if (value.count > 2) {
                NSMutableString *mutable = [[NSMutableString alloc] init];
                for (NSUInteger index = 1; index < value.count; index++) {
                    [mutable appendString:[value mdf_safeObjectAtIndex:index]];
                    [mutable appendString:@"="];
                }
                if (mutable.length >= 1) {
                    NSString *valueStr = [mutable mdf_safeSubstringToIndex:(mutable.length - 1)];
                    [dict mdf_safeSetObject:valueStr forKey:[value firstObject]];
                }
            } else {
                [dict mdf_safeSetObject:[value lastObject] forKey:[value firstObject]];
            }
        }];
    }
    if ([dict allKeys].count > 0) {
        return [[NSDictionary alloc] initWithDictionary:dict];
    }
    return nil;
}

- (BOOL)mdf_isAscii
{
    for (NSUInteger i = 0; i < self.length; i++) {
        if (!isascii([self mdf_safeCharacterAtIndex:i])) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)mdf_isNumbers
{
    for (NSUInteger i = 0; i < self.length; i++) {
        if (!isnumber([self mdf_safeCharacterAtIndex:i])) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)mdf_isTenMultiple
{
    if (self.mdf_isPureInt) {
        return ((self.intValue % 10) == 0);
    } else {
        return NO;
    }
}

- (NSString *)mdf_convertNumberStringToDecimal
{
    NSNumberFormatter*formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInteger:[self integerValue]]];
    return string;
}

- (NSString *)generateCardIDString
{
    NSString *output = self.mdf_stringByTrimingAllWhitespaces;
    if (self.length > 4) {
        output = [output substringFromIndex:(output.length - 4)];
    } else {
        output = output.length ? output : @"";
    }
    return output;
}

- (BOOL)validateUrl
{
    // 可校验带参数的URL，但对于参数的格式无法精确校验，待优化
    NSString *urlRegEx = @"^(http|https)://(\\w+(-|_|\\w)*)((\\.|/)(\\w+(-|_|\\w)*))*(\\?\\S*)?$";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:self];
}

- (NSString *)mdf_appendParameters:(NSDictionary *)parameters
{
    NSEnumerator *enumerator = [parameters keyEnumerator];
    NSString *parameterString = @"";
    id key = nil;
    while ((key = [enumerator nextObject])) {
        NSString *value = [parameters objectForKey:key];
        if (parameterString.length) {
            parameterString = [parameterString stringByAppendingFormat:@"&%@=%@",key,value];
        } else {
            parameterString = [parameterString stringByAppendingFormat:@"%@=%@",key,value];
        }
    }
    
    NSString *output = @"";
    NSURL *url = [NSURL URLWithString:self];
    if ([self rangeOfString:@"?"].length && [url.query mdf_httpRequestBodyDict]) {
        output = [self stringByAppendingFormat:@"&%@",parameterString];
    } else {
        if ([self rangeOfString:@"?"].length) {
            output = [self stringByAppendingFormat:@"%@",parameterString];
        } else {
            output = [self stringByAppendingFormat:@"?%@",parameterString];
        }
    }
    return output;
}

- (BOOL)mdf_isHexadecimalString
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    return [scanner scanHexInt:NULL] && [scanner isAtEnd];
}

//字符串中是否包含了数字，字母以及特殊字符
- (BOOL)mdf_isPureCharacters {
    NSString *noNumStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];//数字
    NSString *noSymbolStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];//符号
    NSString *noPunctuationStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];//标点
    NSString *noIllegalStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet illegalCharacterSet]];//非法符号
    NSString *noAlphanumericStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]];//alpha字母
    
    if(noNumStr.length < self.length || noSymbolStr.length < self.length || noPunctuationStr.length < self.length || noIllegalStr.length < self.length || noAlphanumericStr.length < self.length)
    {
        return NO;
    }
    return YES;
}

- (NSString *)mdf_filterInvalidateHexadecimalCharacter
{
    if ([self mdf_isHexadecimalString]) {
        return self;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *hexadecimalCharecterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefABCDEF"];
    NSString *result = [NSString string];
    NSString *filterString = nil;
    while (![scanner isAtEnd]) {
        BOOL success = [scanner scanCharactersFromSet:hexadecimalCharecterSet intoString:&filterString];
        if (success) {
            result = [result stringByAppendingString:filterString];
        } else {
            if (scanner.scanLocation < self.length) {
                scanner.scanLocation++;
            }
        }
    }
    
    return result;
}

- (NSString *)mdf_numberFiltering
{
    NSString *result = @"";
    NSString *str = self;
    for (int i=0; i<str.length; i++) {
        NSString *s=[str substringWithRange:NSMakeRange(i, 1)];
        const char *ch=[s UTF8String];
        if (*ch>='0'&&*ch<='9') {
            result=[result stringByAppendingString:s];
        }
    }
    return result;
}

- (NSString *)mdf_transverseLineConversionBackslash
{
    if (self.length) {
        return [self stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
    
    return self;
}


@end
