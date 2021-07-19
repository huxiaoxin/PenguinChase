//
//  NSString+TextSize.h
//  GeiNiHua
//
//  Created by ChenYuan on 2018/1/13.
//  Copyright © 2018年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TextSize)

/**
 文本尺寸

 @param fontSize 字体大小
 @param contentSize 文本区域
 @return size
 */
- (CGSize)textWithSize:(CGFloat)fontSize size:(CGSize)contentSize;


/**
 文本尺寸

 @param fontSize 字体大小
 @param contentSize 文本区域
 @param attributes 字体属性
 @return size
 */
- (CGSize)textWithSize:(CGFloat)fontSize size:(CGSize)contentSize attributes:(NSDictionary *)attributes;

@end
