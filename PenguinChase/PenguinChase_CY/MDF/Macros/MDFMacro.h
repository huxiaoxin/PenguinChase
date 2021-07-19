//
//  MDFMacro.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#ifndef MDFMacro_h
#define MDFMacro_h

#pragma mark - DeviceVersionCompare
//~*~*~*~*~*~*~*~**~*~*~*~*~**~*~**~*~*~*~*~*~*~*~*~*~*~*~*~**~*~**~*~**~*~*~**~*~*~*
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion]\
compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion]\
compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion]\
compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion]\
compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion]\
compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark - System Component Size

#define kScreenBounds ([UIScreen mainScreen].bounds)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight  ([UIScreen mainScreen].bounds.size.height)

// UI出图的标准是 750 * 1136
#define kScreenWidthScale (kScreenWidth == 375 ? 1 : (kScreenWidth / 375.f))
#define kScreenHeightScale (kScreenHeight == 668 ? 1 : (kScreenHeight / 668.f))

// 以高度为准，进行等比例宽度进行缩放
#define kScaleWidth(width) (width * kScreenHeightScale)
// 以宽度为准，进行等比例高度进行缩放
#define kScaleHeight(height) (height * kScreenWidthScale)

#define kScreenLine .7f

// 实际X坐标
#define kScaleX(X) (X * kScreenWidthScale)
// 实际Y坐标
#define kScaleY(Y) (Y * kScreenHeightScale)
// 屏幕宽度缩放
#define kZoomScreenWidth(S) (S * kScreenWidth)
// 屏幕高度缩放
#define kZoomScreenHeight(S) (S * kScreenHeight)

#define kSingleLineHeight (1 / [UIScreen mainScreen].scale)
#define kSingleLineOffset ((1 / [UIScreen mainScreen].scale) / 2)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
#define kStatusBarHeight UIApplication.sharedApplication.keyWindow.windowScene.statusBarManager.statusBarFrame.size.height
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#endif


#pragma mark - TICK TOCK

#ifdef DEBUG
#define TICK              NSDate *startTime = [NSDate date]
#define TOCK(x)           NSLog(@"%@ duration: %f", x, -[startTime timeIntervalSinceNow])
#define TOCK_FUNCTION     NSLog(@"%s function duration: %f", __func__, -[startTime timeIntervalSinceNow])
#else

#define TICK
#define TOCK(x)
#define TOCK_FUNCTION
#endif

#pragma mark - SystemTimeZone

#define kTimeZone [NSTimeZone timeZoneWithName:@"Asia/Shanghai"]

#endif /* MDFMacro_h */
