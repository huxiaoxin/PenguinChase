//
//  UILabel+LYExt.h
//  Tools
//
//  Created by ChenYuan on 16/3/11.
//  Copyright © 2016年 ChenYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LYExt)

/**  快速创建Label
 *
 *  @param  title       title
 *  @param  font    字体大小
 *  @param  titleColor  字体颜色
 *
 *  @return Label  返回Label对象
 */
+ (instancetype)ly_LabelWithTitle:(NSString *)title
                             font:(UIFont *)font
                       titleColor:(UIColor *)titleColor;

@end
