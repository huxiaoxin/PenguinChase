//
//  NSAttributedString+RichText.m
//  GeiNiHua
//
//  Created by sanshao on 2017/6/20.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSAttributedString+RichText.h"
#import "NSArray+MDF.h"

@implementation NSAttributedString (RichText)

- (NSAttributedString *)attributedString:(__kindof NSMutableParagraphStyle *)paragrapStyle attribute:(NSDictionary *)attribute range:(NSRange)range
{
    NSValue *value = [NSValue valueWithRange:range];
    return [self attributedString:paragrapStyle attributes:@[attribute] rangeValues:@[value]];
}

- (NSAttributedString *)attributedString:(__kindof NSMutableParagraphStyle *)paragrapStyle
                              attributes:(NSArray<__kindof NSDictionary *> *)attributes
                             rangeValues:(NSArray<__kindof NSValue *> *)rangeValues
{
    if (!self.length) {
        return self;
    }
    
    if (!rangeValues.count) {
        return self;
    }
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.string];

    if (!paragrapStyle) {
        paragrapStyle = [[NSMutableParagraphStyle alloc] init];
        paragrapStyle.alignment = NSTextAlignmentLeft;
        paragrapStyle.lineBreakMode = NSLineBreakByCharWrapping;
    }
    
    [rangeValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSValue *value = (NSValue *)obj;
        NSRange range = value.rangeValue;
        NSDictionary *attribute = [attributes mdf_safeObjectAtIndex:idx];
        NSMutableDictionary *mutableAttribute = [NSMutableDictionary dictionaryWithDictionary:attribute];
        [mutableAttribute setValue:paragrapStyle forKey:NSParagraphStyleAttributeName];
        
        [attributeString addAttributes:mutableAttribute range:range];
    }];
    
    return attributeString;
}

@end
