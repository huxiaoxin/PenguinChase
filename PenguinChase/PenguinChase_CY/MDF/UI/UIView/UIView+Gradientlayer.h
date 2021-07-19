//
//  UIView+Gradientlayer.h
//  AiQiu
//
//  Created by ChenYuan on 2020/5/9.
//  Copyright © 2020 lesports. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Gradientlayer)

- (void)setupViewGradientLayer:(UIView *)view
                    startPoint:(CGPoint)startPoint
                      endPoint:(CGPoint)endPoint
                        colors:(NSArray *)colors
               seperatorPoints:(NSArray *)points;

@end

NS_ASSUME_NONNULL_END
