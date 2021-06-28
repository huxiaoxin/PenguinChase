//
//  CoreAnimationEffect.m
//  SYQuMinApp
//
//  Created by apple on 2018/6/27.
//  Copyright © 2018年 Shuyun. All rights reserved.
//

#import "CoreAnimationEffect.h"

@implementation CoreAnimationEffect
+ (void)showBasicAnimationForView:(UIView *)view keyPath:(NSString *)keyPath fromValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue duration:(CFTimeInterval)duration repeatCount:(NSInteger)repeatCount {
    CABasicAnimation *aniScale = [CABasicAnimation animationWithKeyPath:keyPath];
    aniScale.fromValue = fromValue;
    aniScale.toValue = toValue;
    aniScale.duration = duration;
    aniScale.repeatCount = repeatCount == -1 ? HUGE_VALF : repeatCount;
    [view.layer addAnimation:aniScale forKey:nil];
}

+ (void)showBasicAnimationForView:(UIView *)view keyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(NSNumber *)fromValue toVaule:(NSNumber *)toValue timingFuncion:(CAMediaTimingFunction *)timingFouncion repeatCount:(NSInteger)repeatCount repeatDuration:(NSInteger)repeatDuration removedOnCompletion:(BOOL)removedOnCompletion fillMode:(NSString *)fillMode autorever:(BOOL)autoreversesBOOL{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    basicAnimation.duration = duration;
    basicAnimation.fromValue = fromValue;
    basicAnimation.toValue = toValue;
    basicAnimation.timingFunction = timingFouncion;
    basicAnimation.repeatCount = repeatCount == -1 ? HUGE_VALF : repeatCount;
    basicAnimation.repeatDuration = repeatDuration;
    basicAnimation.removedOnCompletion = removedOnCompletion;
    basicAnimation.fillMode = fillMode;
    basicAnimation.autoreverses = autoreversesBOOL;
    [view.layer addAnimation:basicAnimation forKey:nil];
}

+ (void)showCAKeyframeAnimationsForView:(UIView *)view keyPath:(NSString *)keyPath values1:(CGFloat)value1 values2:(CGFloat)value2 values3:(CGFloat)value3 values4:(CGFloat)value4 duration:(CFTimeInterval)duration repatCount:(NSInteger)repeatCount {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.duration = duration;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(value1, value1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(value2, value2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(value3, value3, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(value4, value4, 1.0)]];
    animation.repeatCount = repeatCount == -1 ? HUGE_VALF : repeatCount;
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)showCAKeyFrameForView:(UIView *)view keyPath:(NSString *)keyPath values:(NSArray *)values fillMode:(NSString *)fillMode duration:(CGFloat)duration repeatCount:(NSInteger)repeatCount {
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = keyPath;
    keyAnima.values = values;
    keyAnima.fillMode = fillMode;
    keyAnima.duration = duration;
    keyAnima.repeatCount = repeatCount == -1 ? MAXFLOAT : repeatCount;
    [view.layer addAnimation:keyAnima forKey:nil];
}
@end
