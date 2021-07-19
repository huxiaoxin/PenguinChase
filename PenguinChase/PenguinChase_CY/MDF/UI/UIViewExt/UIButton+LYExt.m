//
//  UIButton+LYExt.m
//  Tools
//
//  Created by ChenYuan on 16/3/11.
//  Copyright © 2016年 ChenYuan. All rights reserved.
//

#import "UIButton+LYExt.h"

@implementation UIButton (LYExt)

+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName selecteImageName:(NSString *)sImageName font:(UIFont *)font target:(id)target selector:(SEL)selector {
    
    UIImage *nImage;
    UIImage *sImage;
    if (nImageName.length > 0) {
        nImage = [UIImage imageNamed:nImageName];
    }else {
        nImage = nil;
    }
    if (sImageName.length > 0) {
        sImage = [UIImage imageNamed:sImageName];
    }else {
        sImage = nil;
    }
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    if (font != nil) {
        btn.titleLabel.font = font;
    }
    [btn setImage:nImage forState:UIControlStateNormal];
    [btn setImage:sImage forState:UIControlStateSelected];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName selecteImageName:(NSString *)sImageName target:(id)target selector:(SEL)selector {
    return [self ly_ButtonWithNormalImageName:nImageName selecteImageName:sImageName font:nil target:target selector:selector];
}

+ (instancetype)ly_ButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target selector:(SEL)selector {
    UIButton *btn = [self ly_ButtonWithNormalImageName:nil selecteImageName:nil font:(UIFont *)font target:target selector:selector];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
}

@end
