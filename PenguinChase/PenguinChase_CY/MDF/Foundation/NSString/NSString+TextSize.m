//
//  NSString+TextSize.m
//  GeiNiHua
//
//  Created by ChenYuan on 2018/1/13.
//  Copyright © 2018年 GNH. All rights reserved.
//

#import "NSString+TextSize.h"

@implementation NSString (TextSize)

- (CGSize)textWithSize:(CGFloat)fontSize size:(CGSize)contentSize 
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return [self textWithSize:fontSize size:contentSize attributes:@{NSFontAttributeName : font}];
}

- (CGSize)textWithSize:(CGFloat)fontSize size:(CGSize)contentSize attributes:(NSDictionary *)attributes;
{
    CGSize tmpsize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    if (contentSize.height) {
        tmpsize = contentSize;
    }
    
    NSMutableDictionary *mutableAttributes = [[NSMutableDictionary alloc] initWithDictionary:attributes];
    [mutableAttributes mdf_safeSetObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];

    CGSize size = [self boundingRectWithSize:tmpsize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:mutableAttributes
                                     context:nil].size;
    
    return size;
}

@end
