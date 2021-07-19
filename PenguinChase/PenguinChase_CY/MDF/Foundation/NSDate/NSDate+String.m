//
//  NSDate+String.m
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-12.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

#import "NSDate+String.h"
#import <mach/mach_time.h>

#ifdef DEBUG
extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));
#endif

@implementation NSDate (String)

- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

- (BOOL)isYesterday {
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateWithYMD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSString *)weekdayStringWithDate {
    //获取星期几
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    NSInteger weekday = [componets weekday];//1代表星期日，2代表星期一，后面依次
    NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSString *weekStr = weekArray[weekday-1];
    
    return weekStr;
}

- (NSDateComponents *)deltaWithNow {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

- (NSDateFormatter *)dateFormater {
    NSString *formatKey = @"yyyy-MM-dd HH:mm:ss:SSS";
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = formatKey;
    return dateformatter;
}

- (NSDateFormatter *)dateFormaterer2 {
    NSString *formatKey = @"HH:mm:ss";
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = formatKey;
    return dateformatter;
}

- (NSString *)currentTimeString {
    NSString * newTimeStr = [self.dateFormater stringFromDate:self];
    return newTimeStr;
}

- (NSString *)currentTimeStringType2 {
    NSString * newTimeStr = [self.dateFormaterer2 stringFromDate:self];
    return newTimeStr;
}

#pragma mark - 调试代码 返回运行时长
+ (CGFloat)codeTimeBlock:(void (^)(void))block {
#ifdef DEBUG
    uint64_t t = dispatch_benchmark(10, block);
    CGFloat time = (CGFloat)t / NSEC_PER_SEC;
#else
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;
    
    uint64_t start = mach_absolute_time ();//纳秒级的精确度
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    CGFloat time = (CGFloat)nanos / NSEC_PER_SEC;
#endif
    NSLog(@"This code runtime：%lf(s)", time);
    return time;
}

@end
