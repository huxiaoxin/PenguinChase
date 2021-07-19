//
//  UITextField+LYExt.m
//  Tools
//
//  Created by ChenYuan on 16/3/11.
//  Copyright © 2016年 ChenYuan. All rights reserved.
//

#import "UITextField+LYExt.h"

@implementation UITextField (LYExt)
+ (instancetype)ly_TextFieldWithPlaceholder:(NSString *)placeholder font:(UIFont *)font {
    UITextField *textField = [[self alloc] init];
    textField.placeholder = placeholder;
    textField.font = font;
    return textField;
}
@end
