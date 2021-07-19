//
//  UILabel+LYExt.m
//  Tools
//
//  Created by ChenYuan on 16/3/11.
//  Copyright © 2016年 ChenYuan. All rights reserved.
//

#import "UILabel+LYExt.h"

@implementation UILabel (LYExt)
+ (instancetype)ly_LabelWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor {
    UILabel *label = [[self alloc] init];
    label.textColor = titleColor;
    label.font = font;
    label.text = title;
    return label;
}
@end
