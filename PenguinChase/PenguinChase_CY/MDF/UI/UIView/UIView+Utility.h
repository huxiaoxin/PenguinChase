//
//  UIView+Utility.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/6/15.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MDFGestureRecognizerActionBlock)(UIGestureRecognizer *gestureRecognizer);
typedef void(^MDFGestureRecognizerConfigBlock)(UIGestureRecognizer *gestureRecognizer);

@interface UIView (Utility)

// 点击
- (void)mdf_whenSingleTapped:(MDFGestureRecognizerActionBlock)block;
- (void)mdf_whenSingleTapped:(MDFGestureRecognizerActionBlock)block gestureConfigBlock:(MDFGestureRecognizerConfigBlock)block;

@end
