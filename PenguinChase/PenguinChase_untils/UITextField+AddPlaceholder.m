//
//  UITextField+AddPlaceholder.m
//  SYQuMinApp
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 Shuyun. All rights reserved.
//

#import "UITextField+AddPlaceholder.h"

@implementation UITextField (AddPlaceholder)

- (void)addPlaceholders:(UIFont *)placeFont holderStr:(NSString *)str holderColor:(UIColor *)color{ // 占位符的字体大小
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:placeFont,NSForegroundColorAttributeName:color}];

    /*
    // iOS13 使用这个kvc方法会产生奔溃, 关闭使用
    或者使用这个方法也可以, 以后再有这个需求可以加上
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"姓名" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]}];
    */
//    [self setValue:placeFont forKeyPath:@"_placeholderLabel.font"];
    
}
@end
