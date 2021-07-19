//
//  NSDate+String.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-12.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <NSDate+YYAdd.h>

@interface NSDate (String)

// 是否为今天
- (BOOL)isToday;

// 是否为昨天
- (BOOL)isYesterday;

// 是否为今年
- (BOOL)isThisYear;

// 输出星期几
- (NSString *)weekdayStringWithDate;

// 返回一个只有年月日的时间
- (NSDate *)dateWithYMD;

// 获得与当前时间的差距
- (NSDateComponents *)deltaWithNow;

// 时间转换格式 yyyy-MM-dd HH:mm:ss:SSS
- (NSDateFormatter *)dateFormater;

// 时间转换格式 HH:mm:ss
- (NSDateFormatter *)dateFormaterer2;

// 获取当前时间戳字符串
- (NSString *)currentTimeString;

// 获取当前时间戳字符串
- (NSString *)currentTimeStringType2;

// 调试代码 返回运行时长
+ (CGFloat)codeTimeBlock:(void (^)(void))block;

@end
