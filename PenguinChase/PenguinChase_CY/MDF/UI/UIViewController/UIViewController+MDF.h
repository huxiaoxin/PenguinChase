//
//  UIViewController+MDF.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/24.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MDF)

// 根控制器present出来的最上面的viewController
+ (UIViewController *)mdf_stackTopViewController;
// 当前控制器present出来的最上面的viewcontroller
- (UIViewController *)mdf_visibleViewController;
// 最下面的presentingViewController
- (UIViewController *)mdf_farthestPresentingViewController;
// 最顶层的Viewcontroller 不包括childViewController
+ (UIViewController *)mdf_toppestViewController;
// 获取rootVC开始的最上层viewController
+ (UIViewController *)mdf_toppestViewControllerFromRootVC:(UIViewController *)rootVC;

@end
