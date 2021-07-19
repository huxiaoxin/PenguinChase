//
//  UIColor+LYString.h
//  99fenqi
//
//  Created by ChenYuan on 16/5/12.
//  Copyright © 2016年 dingli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LYString)

/** 将16进制颜色值如#000000转换成UIColor */
+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
