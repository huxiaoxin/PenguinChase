//
//  NSString+Utility.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - sring
#ifdef __cplusplus
extern "C" {
#endif
    
    extern NSString *unemptyString(NSString *orgString, NSString *replacementString);
    
    extern NSString *unemptyStringByDefault(NSString *orgString);
    
    extern id unnullObjectDyDefault(id obj);
    
    extern BOOL doubleEquals(double a, double b);
    
#ifdef __cplusplus
}
#endif

#pragma mark - NSStirng
@interface NSString (Utility)

#pragma mark - jsonExtensions json扩展
- (id)mdf_jsonValue;

- (NSDictionary *)mdf_jsonValueToDictionary;

- (NSArray *)mdf_jsonValueToArray;

- (NSString *)mdf_jsonValueToString;

#pragma mark - typeJudge 类型判断
// 判断是否为整形：
- (BOOL)mdf_isPureInt;

// 判断是否为浮点形：@“”、nil的情况都返回NO
- (BOOL)mdf_isPureFloat;

#pragma mark - regularJudge 正则判断
// 用户名
- (BOOL)mdf_isValidatedUserName;

// 密码
- (BOOL)mdf_isValidatedPassword;

// 昵称
- (BOOL)mdf_isValidatedNickname;

// 中文姓名
- (BOOL)mdf_isChineseName;

// 过滤中文名(包含少数民族)、外国人名(中文、数字、字母、.、·)
- (NSString *)mdf_chineseOrAbroadName;

// 邮箱
- (BOOL)mdf_isValidatedEmail;

// 身份证号
- (BOOL)mdf_isValidatedIdentityCard;

// 座机号
- (BOOL)mdf_isValidatedTelLandline;

// 手机号(非手机库效验)
- (BOOL)mdf_isValidatedMobile;

// 是否包含
- (BOOL)mdf_contains:(NSString *)string;

// 是否包含中文
- (BOOL)mdf_containsChinese;

// 是否包含emoji表情
- (BOOL)mdf_containsEmoji;

// 是否全部都为中文
- (BOOL)mdf_isPureChinese;

// 是否是全数字
- (BOOL)mdf_isNumbers;

// 是否是全是ascii字符
- (BOOL)mdf_isAscii;

// 判读输入的数字是否是10的整数倍
- (BOOL)mdf_isTenMultiple;

// 判断是否为有效的url
- (BOOL)validateUrl;

// 判断是否为16进制字符串
- (BOOL)mdf_isHexadecimalString;

//字符串中是否包含了数字，字母以及特殊字符
- (BOOL)mdf_isPureCharacters;

//字符串是否为空
+ (BOOL)mdf_isEmptyString:(NSString *)aString;

#pragma Mark -
#pragma mark - functionExtensions 功能扩展
// 小数部分全部为0时去掉小数点及后面的0
- (NSString *)mdf_trimExtraDot;

// 去除首尾空格或换行符
- (NSString *)mdf_stringByTrimingWhitespaceOrNewlineCharacter;

// 去除所有的空格
- (NSString *)mdf_stringByTrimingAllWhitespaces;

// 返回行数
- (NSUInteger)mdf_numberOfLines;

// 是否包含,并且返回NSRange
- (NSRange)mdf_containsAndRange:(NSString *)string;

// 获取文件名称
- (NSString *)mdf_fileName;

// mdf5
- (NSString *)mdf_md5;

// 返回格式化后的手机号 (若不是11位 直接返回)
- (NSString *)mdf_formatPhoneNumber;

// 去除手机号中的异常字符
- (NSString *)mdf_purePhoneNumber;

// 返回格式化的身份证号码
- (NSString *)mdf_formatIdentification;

// 返回格式化的银行卡
- (NSString *)mdf_formatBankCardNumber;

// 返回格式化的身份证号 xxx xxx xxxx xxxx xxxx
- (NSString *)mdf_formatCardIDNumber;

// 取银行卡号后四位
- (NSString *)generateCardIDString;

// url 拼接参数
- (NSString *)mdf_appendParameters:(NSDictionary *)parameters;

// 返回http request dict (如 user_id=123456&user_name=gnh 转成 {user_id:123456,user_name:gnh} )
- (NSDictionary *)mdf_httpRequestBodyDict;

// 过滤掉字符串中的非16进制字符
- (NSString *)mdf_filterInvalidateHexadecimalCharacter;

/**筛数字,只留下数字*/
- (NSString *)mdf_numberFiltering;

/** 横线转换成反斜杠 '-' -> '/' */
- (NSString *)mdf_transverseLineConversionBackslash;
@end
