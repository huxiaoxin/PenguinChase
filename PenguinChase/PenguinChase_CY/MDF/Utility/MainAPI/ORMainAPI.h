//
//  ORMainAPI.h
//  ORMainAPI
//
//  Created by 似水灵修 on 16/7/7.
//  Copyright © 2016年 ZY. All rights reserved.
//  

@import Foundation;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ORMainAPIJumpType) {
    ORMainAPIJumpNone,
    ORMainAPIJumpPush,
    ORMainAPIJumpModal,
};


@interface ORMainAPI : NSObject
/** 获取当前Window */
+ (nullable UIWindow *)appWindow;
/** 获取keyWindow rootViewController */
+ (nullable __kindof UIViewController *)rootVC;
/** 获取当前显示的ViewController，忽略【特殊视图控制器】 */
+ (nullable __kindof UIViewController *)currentVC;
/** 获取当前显示的ViewController，不会忽略【特殊视图控制器】 */
+ (nullable __kindof UIViewController *)currentVCDisplay;
/** 根控制器UITabBarController，切换TabBar选项视图 */
+ (void)tabBarSelectedWithIndex:(NSUInteger)index;

/**
 离开当前页面

 @param page 页面控制器
 @param animated 动画
 @param completion 回调
 */
+ (void)leaveCurrentPage:(UIViewController *)page animated:(BOOL)animated completion:(nullable void (^)(void))completion;
/** 离开当前页面，默认动画 */
+ (void)leaveCurrentPage:(UIViewController *)page completion:(nullable void (^)(void))completion;

/**
 视图控制器跳转
 
 @param toVC 目标控制器
 @param fromVC 来源控制器
 @param type 跳转类型
 @param animated 动画
 @param completion 跳转完成后回调
 */
+ (void)jumpToVC:(UIViewController *)toVC
          fromVC:(UIViewController *)fromVC
            type:(ORMainAPIJumpType)type
        animated:(BOOL)animated
      completion:(nullable void (^)(void))completion;
/**
 通过"setViewControllers:"视图控制器，实现视图跳转
 
 @param vc 目标控制器
 @param removeVC 需要移除的控制器
 */
+ (void)jumpPushToVC:(UIViewController *)vc removeVC:(UIViewController *)removeVC;

/**
 打电话
 
 @param phone 手机号
 */
+ (void)callPhone:(NSString *)phone completion:(nullable void (^)(BOOL success))completion;
/**
 通过scheme调用相应功能
 
 @param scheme 协议
 @param completion 回调处理
 */
+ (void)openScheme:(NSString *)scheme completion:(nullable void (^)(BOOL success))completion;

/**
处理特殊字符
@code
1. 编码中文、《》、（）、【】
2. 空格替换为空字符
*/
+ (NSString *)stringAddingPercentEscapesChineseSpace:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
