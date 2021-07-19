//
//  UIView+Gradientlayer.m
//  AiQiu
//
//  Created by ChenYuan on 2020/5/9.
//  Copyright © 2020 lesports. All rights reserved.
//

#import "UIView+Gradientlayer.h"

@implementation UIView (Gradientlayer)

- (void)setupViewGradientLayer:(UIView *)view startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray *)colors seperatorPoints:(NSArray *)points
{
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [view.layer insertSublayer:gradientLayer atIndex:0];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    
    //设置颜色数组
    gradientLayer.colors = colors;
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = points;
}


@end
