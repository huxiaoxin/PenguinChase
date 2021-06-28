//
//  NSString+CHRegex.h
// codehzx@163.com
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 gch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CHRegex)
/** 判断是否含有regex字符 */
- (BOOL)isValidateWithRegex:(NSString *)regex;
/** 邮箱验证 */
- (BOOL)isValidEmail;

/** 手机号码验证 */
- (BOOL)isValidPhoneNum;
/** 手机号中间四位用****显示*/
+ (NSString *)numberPhoneSuitScanf:(NSString *)phone strRange:(NSRange)strRange;

/** 指定位置****显示*/
+(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght;	

/** 车牌号验证 */
- (BOOL)isValidCarNo;

/** 网址验证 */
- (BOOL)isValidUrl;

/** 邮政编码 */
- (BOOL)isValidPostalcode;

/** 纯汉字 */
- (BOOL)isValidChinese;


/**
 @brief     是否符合IP格式，xxx.xxx.xxx.xxx
 */
- (BOOL)isValidIP;

/** 身份证验证*/
- (BOOL)isValidIdCardNum;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/** 去掉两端空格和换行符 */
- (NSString *)stringByTrimmingBlank;
/** 取消字符串中的空格*/
- (NSString *)stringReplacing;
/// 指定字符串被替换, ofString是需要被替换的字符串, wString是替换的字符串
- (NSString *)chStringByReplacingOfString:(NSString *)ofString withString:(NSString *)wString;

/** 去掉html格式 */
- (NSString *)removeHtmlFormat;

/** MD5加密 */
- (NSString *)MD5String;

/** 判断是否是空字符串 */
+ (BOOL) isBlankString:(NSString *)str;

/** 字符串拼接随机数 */
+ (NSString *)stringConcatentationRobot:(NSString *)str;


/** json字符串转对象 */
//- (NSDictionary *)dictionaryWithJsonString;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)string;
/** 字典转json字符串*/
+ (NSString *)dictionaryTurnJsonString:(NSDictionary *)dictionary;
/** 数组转json字符串*/
+ (NSString *)arrayTurnJsonString:(NSArray *)array;
/** json字符串转数组*/
+ (NSArray *)stringJsonToArray:(NSString *)string;
/** 工商税号 */
- (BOOL)isValidTaxNo;
/** 取消字符串中的空格换行符*/
- (NSString *)noWhiteSpaceString;


#pragma mark ----
// 获取Label宽
- (CGSize)getStringWidthIncomingHeight:(CGFloat)textHeight fontSize:(CGFloat)font fontName:(NSString *)fontName textColor:(UIColor *)textColor;

// 获取Label高
- (CGSize)getStringHeightIncomingWidth:(CGFloat)textWidth fontSize:(CGFloat)font fontName:(NSString *)fontName textColor:(UIColor *)textColor;

- (CGSize)cxl_sizeWithString:(UIFont *)font;
- (CGRect)cxl_sizeWithMoreString:(UIFont *)font maxWidth:(CGFloat)width;

// 签名算法
- (NSString *)getUrlEncode;

//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;

// URLEncode转码
- (NSString *)URLEncodedString;

// 字符串转utf-8
- (NSString *)stringUTF8;
// utf-8转字符串
- (NSString *)utf8String;

// 转换为Base64编码
- (NSString *)base64EncodedString;

// 将Base64编码还原
- (NSString *)base64DecodedString;

#pragma mark --
// 获取当前时间
+ (NSString *)currentDateStr;

// 获取当前时间戳
+ (NSString *)currentTimeStr;

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr;
- (NSString *)getDateStringWithTimeStrNOHMS;

//字符串转时间戳 如：2017-4-10 17:15:10
- (NSString *)getTimeStrWithString;
//将字符串转成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString;
//传入今天的时间，返回明天的时间
+ (NSString *)getTomorrowDay:(NSDate *)aDate;
/// 过滤指定字符, 过滤addString之外的字符
+ (NSString *)filterCharactor:(NSString *)string Addition:(NSString *)addString;

#pragma mark -- 随机生成指定位数字符串
+ (NSString *)randomStringWithLength:(NSInteger)len;
#pragma mark -- 字符串是否包含某些字符
+ (BOOL)stringDoesitIncludeString:(NSString *)string containsString:(NSString *)str;
#pragma mark -- uuid
+ (NSString *)getCurrentDeviceUUID;
// 直接显示html标签文本, 显示不全...
+ (NSMutableAttributedString *)getChiesMutableAttributedString:(NSString *)str;
@end
