//
//  UITextView+LYExt.h
//  GeiNiHua
//
//  Created by ChenYuan on 16/7/5.
//  Copyright © 2016年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LYExt)
/**  快速创建TextView
 *  @param  text         文本
 *  @param  font     字体大小
 *  @param  delegate     代理
 *  @return TextField  返回TextView对象
 */
+ (instancetype)ly_TextViewWithText:(NSString *)text
                               font:(UIFont *)font
                          textColor:(UIColor *)textColor
                           delegate:(id<UITextViewDelegate>)delegate;

@end
