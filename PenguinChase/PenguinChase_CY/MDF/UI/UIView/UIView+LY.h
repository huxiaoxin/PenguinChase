//
//  UIView+LY.h
//  shuaidanbao
//
//  Created by ChenYuan on 15/12/28.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LY)

// 裁剪view的某几个角
- (instancetype)cutWithCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner;

- (instancetype)cutWithCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

- (UIView *)clipCornerWithView:(UIView *)originView
                    andTopLeft:(BOOL)topLeft
                   andTopRight:(BOOL)topRight
                 andBottomLeft:(BOOL)bottomLeft
                andBottomRight:(BOOL)bottomRight;

@end
