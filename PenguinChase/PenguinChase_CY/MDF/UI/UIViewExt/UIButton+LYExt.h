//
//  UIButton+LYExt.h
//  Tools
//
//  Created by ChenYuan on 16/3/11.
//  Copyright © 2016年 ChenYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LYExt)
/**  快速创建button
 *  @param  nImageName   默认状态图片名
 *  @param  sImageName  选择状态图片名
 *  @param  font          字体大小, NSNotFound为系统默认值
 *  @param  target            回调对象
 *  @param  selector          回调方法
 *  @return Button      返回Button对象
 */
+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName
                            selecteImageName:(NSString *)sImageName
                                        font:(UIFont *)font
                                      target:(id)target
                                    selector:(SEL)selector;

/**  快速创建button
 *  @param  nImageName   默认状态图片名
 *  @param  sImageName  选择状态图片名
 *  @param  target            回调对象
 *  @param  selector          回调方法
 *  @return Button      返回Button对象
 */
+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName
                         selecteImageName:(NSString *)sImageName
                                   target:(id)target
                                 selector:(SEL)selector;

/**
 快速创建button

 @param title       title, UIControlStateNormal状态
 @param titleColor  titleColor, UIControlStateNormal状态
 @param font    字体大小，NSNotFound为系统默认值
 @param target       回调对象
 @param selector    回调方法
 @return            对象
 */
+ (instancetype)ly_ButtonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                            target:(id)target
                          selector:(SEL)selector;

@end
