//
//  UITextField+LYExt.h
//  Tools
//
//  Created by ChenYuan on 16/3/11.
//  Copyright © 2016年 ChenYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LYExt)

/**  快速创建TextField
 *
 *  @param  placeholder  占位符
 *  @param  font     字体大小
 *
 *  @return TextField  返回TextField对象
 */
+ (instancetype)ly_TextFieldWithPlaceholder:(NSString *)placeholder font:(UIFont *)font;

@end
