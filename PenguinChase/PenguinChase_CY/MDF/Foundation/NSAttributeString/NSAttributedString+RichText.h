//
//  NSAttributedString+RichText.h
//  GeiNiHua
//
//  Created by sanshao on 2017/6/20.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (RichText)


/**
  富文本字符串

 @param paragrapStyle 样式
 @param attribute 属性样式字典
 @param range 范围
 @return 返回富文本
 */
- (__kindof NSAttributedString *__nonnull)attributedString:(__kindof NSMutableParagraphStyle *__nullable)paragrapStyle
                                        attribute:(NSDictionary * __nonnull)attribute
                                            range:(NSRange)range;

/**
 富文本字符串

 @param paragrapStyle 样式
 @param attributes 属性样式字典
 @param rangeValues 修改范围数组
 @return 返回富文本
 */
- (__kindof NSAttributedString *__nonnull)attributedString:(__kindof NSMutableParagraphStyle *__nullable)paragrapStyle
                                       attributes:(NSArray<__kindof NSDictionary *> * __nonnull)attributes
                                      rangeValues:(NSArray<__kindof NSValue *> * __nonnull)rangeValues;


@end
