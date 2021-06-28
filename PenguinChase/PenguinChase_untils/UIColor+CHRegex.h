//
//  UIColor+CHRegex.h
//  codehzx@163.com
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 Shuyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CHRegex)
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
+ (UIColor *)colorWithHex:(NSString *)hexColor  hexAlpha:(NSString *)hexAlpha;
//16进制颜色转换
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha;
@end
