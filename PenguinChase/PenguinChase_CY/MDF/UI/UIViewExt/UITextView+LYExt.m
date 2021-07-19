//
//  UITextView+LYExt.m
//  GeiNiHua
//
//  Created by ChenYuan on 16/7/5.
//  Copyright © 2016年 GNH. All rights reserved.
//

#import "UITextView+LYExt.h"

@implementation UITextView (LYExt)
+ (instancetype)ly_TextViewWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor delegate:(id<UITextViewDelegate>)delegate {
    UITextView *textView = [[self alloc] init];
    textView.text = text;
    textView.textColor = textColor;
    textView.delegate = delegate;
    if (font != nil) {
        textView.font = font;
    }
    return textView;
}
@end
