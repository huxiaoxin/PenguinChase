//
//  UIViewController+MDF.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/24.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "UIViewController+MDF.h"
#import "MDFMacro.h"

@implementation UIViewController (MDF)

+ (UIViewController *)mdf_stackTopViewController
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = rootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (UIViewController *)mdf_visibleViewController
{
    UIViewController *visibleViewController = self;
    while (visibleViewController.presentedViewController != nil) {
        visibleViewController = visibleViewController.presentedViewController;
    }
    return visibleViewController;
}

- (UIViewController *)mdf_farthestPresentingViewController
{
    UIViewController *visibleViewController = self ;
    UIViewController *presentingViewController = visibleViewController.presentingViewController;
    while (presentingViewController) {
        id temp = presentingViewController;
        presentingViewController = [presentingViewController presentingViewController];
        visibleViewController = temp;
    }
    return visibleViewController;
}

+ (BOOL)shouldIgnoreViewController:(UIViewController *)viewController
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return [viewController isKindOfClass:[UIAlertController class]];
    }
    return NO;
}

+ (UIViewController *)mdf_toppestViewController
{
    return [self mdf_toppestViewControllerFromRootVC:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)mdf_toppestViewControllerFromRootVC:(UIViewController *)rootVC
{
    UIViewController *topVC = rootVC;
    UIViewController *presentedViewControlelr = topVC.presentedViewController;
    while (presentedViewControlelr) {
        if (presentedViewControlelr && ![self shouldIgnoreViewController:presentedViewControlelr]) {
            topVC = presentedViewControlelr;
        }
        presentedViewControlelr = presentedViewControlelr.presentedViewController;
    }
    if ([topVC isKindOfClass:[UITabBarController class]]) {
        topVC = ((UITabBarController *)topVC).selectedViewController;
    }
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        topVC = ((UINavigationController *)topVC).topViewController;
    }
    return topVC;
}

@end
