//
//  CoreAnimationEffect.h
//  SYQuMinApp
//
//  Created by apple on 2018/6/27.
//  Copyright © 2018年 Shuyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoreAnimationEffect : NSObject
#pragma mark -- view动画显示, 放大
+ (void)showBasicAnimationForView:(UIView *)view keyPath:(NSString *)keyPath fromValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue duration:(CFTimeInterval)duration repeatCount:(NSInteger)repeatCount;
#pragma mark -- view移动动画
+ (void)showBasicAnimationForView:(UIView *)view keyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(NSNumber *)fromValue toVaule:(NSNumber *)toValue timingFuncion:(CAMediaTimingFunction *)timingFouncion repeatCount:(NSInteger)repeatCount repeatDuration:(NSInteger)repeatDuration removedOnCompletion:(BOOL)removedOnCompletion fillMode:(NSString *)fillMode autorever:(BOOL)autoreversesBOOL;

#pragma mark -- view放大缩小动画
+ (void)showCAKeyframeAnimationsForView:(UIView *)view keyPath:(NSString *)keyPath values1:(CGFloat)value1 values2:(CGFloat)value2 values3:(CGFloat)value3 values4:(CGFloat)value4 duration:(CFTimeInterval)duration repatCount:(NSInteger)repeatCount;

#pragma mark -- 左右晃动动画
+ (void)showCAKeyFrameForView:(UIView *)view keyPath:(NSString *)keyPath values:(NSArray *)values fillMode:(NSString *)fillMode duration:(CGFloat)duration repeatCount:(NSInteger)repeatCount;
                                                                                                                                                                                                                                                                                    
@end
