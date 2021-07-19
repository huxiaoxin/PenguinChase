//
//  GNHBaseTextField.m
//  AiQiu
//
//  Created by ChenYuan on 2020/4/20.
//  Copyright © 2020 lesports. All rights reserved.
//

#import "GNHBaseTextField.h"

@implementation GNHBaseTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect leftRect = [super leftViewRectForBounds:bounds];
    leftRect.origin.x += self.leftViewGap; //右边偏10
    return leftRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect rightRect = [super rightViewRectForBounds:bounds];
    rightRect.origin.x += self.rightViewGap; //左边偏7
    return rightRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += self.textRectLeftGap; // 左边偏移10
    return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += self.editingRectLeftGap; // 左边偏移10
    return textRect;
}

@end
