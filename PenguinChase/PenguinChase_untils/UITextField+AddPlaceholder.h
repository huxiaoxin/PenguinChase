//
//  UITextField+AddPlaceholder.h
//  SYQuMinApp
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 Shuyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (AddPlaceholder)
- (void)addPlaceholders:(UIFont *)placeFont holderStr:(NSString *)str holderColor:(UIColor *)color; // 占位符的字体大小
@end
