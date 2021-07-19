//
//  ORKitMacros.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/11/1.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "ORKitMacros.h"

static CGFloat const kNavigationBarHeight_t = 44.0;
static CGFloat const kStatusBarHeight_t = 20.0;
static CGFloat const kStatusBarHeight_iPhoneX_t = 44.0;
static CGFloat const kTabBarHeight_t = 49.0;

static CGFloat navigationBarHeight_t = 0.0;
static CGFloat statusBarHeight_t = 0.0;
static CGFloat tabBarHeight_t = 0.0;

@implementation ORKitMacros

+ (CGFloat)navigationBarHeight {
    if (navigationBarHeight_t < 1) {
        navigationBarHeight_t = kNavigationBarHeight_t;
    }
    return navigationBarHeight_t;
}

+ (CGFloat)statusBarHeight {
    if (statusBarHeight_t < 1) {
        if ([UIDevice ly_hasFringeScreen]) {
            statusBarHeight_t = kStatusBarHeight_iPhoneX_t;
        } else {
            statusBarHeight_t = kStatusBarHeight_t;
        }
    }
    return statusBarHeight_t;
}
+ (CGFloat)tabBarHeight {
    if (tabBarHeight_t < 1) {
        if ([UIDevice ly_hasFringeScreen]) {
            tabBarHeight_t = kTabBarHeight_t + 34.0;
        } else {
            tabBarHeight_t = kTabBarHeight_t;
        }
    }
    return tabBarHeight_t;
}

+ (CGFloat)iphoneXSafeHeight {
    CGFloat iphoneX_gap_height = 0.0f;
    if ([UIDevice ly_hasFringeScreen]) {
        iphoneX_gap_height = 34.0f;
    }
    return iphoneX_gap_height;
}

@end
