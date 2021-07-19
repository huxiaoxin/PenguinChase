//
//  NSString+LY.h
//  shuaidanbao
//
//  Created by ChenYuan on 15/9/11.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LY)

/** 获取与字符串相等长度的符号（symbol）字符串
 */
- (NSString *)replaceStringSymbol:(NSString *)symbol;
/**  用symbol替换字符串中range位置的每一个字符
 *  @return range.length = 0，返回原字符串,range.location 如果不在 字符串长度范围内，返回原字符串
 */
- (NSString *)replaceStringSymbol:(NSString *)symbol range:(NSRange)range;
/**  @return 返回number个原字符串拼接的新字符串,
 */
- (NSString *)repeatStringNumber:(NSUInteger)number;
/**  json字符串转字典
 */
+ (NSDictionary *)jsonDicTransFromStr:(NSString *)dataStr;

/** 数据大小转换KB、MB、GB */
+ (NSString *)fileSizeToString:(unsigned long long)fileSize;



/**  格式处理数字 自行处理小数位数，flag NO=不保留小数位 YES=保留小数位，
 *  如：number=123400090 count=3 separator=@","
 *  返回：123,400,090
 */
+ (NSString *)getFormatForNum:(NSNumber *)num count:(NSInteger)count separator:(NSString *)separator flag:(BOOL)flag;
/**  格式处理数字，不保留小数位
 *  如：number=123400090 count=3 separator=@","
 *  返回：123,400,090
 */
+ (NSString *)getFormatForNum:(NSNumber *)num count:(NSInteger)count separator:(NSString *)separator;



//验证身份证 
- (BOOL)checkShenFenZheng;

//验证手机号
- (BOOL)checkMobile;

//验证邮箱
- (BOOL)checkEmail;

//验证邮编
- (BOOL)checkPostcode;

//校验银行卡卡号
- (BOOL)checkBankCard;

//验证是否是中文
- (BOOL)checkChinese;
//重写系统判断字符串方法
- (BOOL)containsString:(NSString *)str;

@end
