//
//  ORMainAPI.m
//  ORMainAPI
//
//  Created by 似水灵修 on 16/7/7.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ORMainAPI.h"

@implementation ORMainAPI

+ (__kindof UIViewController *)rootVC {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

+ (void)jumpPushToVC:(UIViewController *)vc removeVC:(UIViewController *)removeVC {
    UINavigationController *navVC = removeVC.navigationController;
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:navVC.viewControllers];
    [arrayM enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == removeVC) {
            [arrayM removeObject:obj];
            *stop = YES;
        }
    }];
    [arrayM addObject:vc];
    [navVC setViewControllers:arrayM animated:YES];
}

+ (void)jumpToVC:(UIViewController *)toVC
          fromVC:(UIViewController *)fromVC
            type:(ORMainAPIJumpType)type
        animated:(BOOL)animated
      completion:(void (^)(void))completion {
    switch (type) {
        case ORMainAPIJumpModal:
        {
            [fromVC presentViewController:toVC animated:animated completion:^{
                if (completion) {
                    completion();
                }
            }];
        }
            break;
        case ORMainAPIJumpPush:
        case ORMainAPIJumpNone:
        default:
        {
            [[fromVC navigationController] pushViewController:toVC animated:animated];
            if (completion) {
                completion();
            }
        }
            break;
    }
}

/** 获取当前Window */
+ (UIWindow *)appWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //app Window的windowLevel默认是UIWindowLevelNormal
    if (!window || window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}

/** 获取当前显示的ViewController，忽略特殊视图控制器 */
+ (UIViewController *)currentVC{
    return [self currentViewControllerIgnore:YES];
}

/** 获取当前显示的ViewController，不会忽略特殊视图控制器 */
+ (UIViewController *)currentVCDisplay {
    return [self currentViewControllerIgnore:NO];
}

+ (UIViewController *)currentViewControllerIgnore:(BOOL)ignore {
    __kindof UIViewController *currentVisibleVC = [self appWindow].rootViewController;
    while (currentVisibleVC.presentedViewController) {
        if (ignore) {
            if ([self ignoreController:currentVisibleVC.presentedViewController]) {
                return currentVisibleVC;
            } else {
                currentVisibleVC = currentVisibleVC.presentedViewController;
            }
        } else {
            currentVisibleVC = currentVisibleVC.presentedViewController;
        }
    }
    if ([currentVisibleVC isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabBarVC = currentVisibleVC;
        
        NSUInteger count = tabBarVC.viewControllers.count;
        if (count < 6) {
            currentVisibleVC = tabBarVC.selectedViewController;
        } else {
            if (tabBarVC.selectedIndex < 4) {
                currentVisibleVC = tabBarVC.selectedViewController;
            } else {
                if (tabBarVC.moreNavigationController.viewControllers.count) {
                    currentVisibleVC = tabBarVC.moreNavigationController.viewControllers.lastObject;
                }
            }
        }
    }
    if ([currentVisibleVC isKindOfClass:[UINavigationController class]]) {
        currentVisibleVC = [(UINavigationController *)currentVisibleVC topViewController];
    }
    return currentVisibleVC;
}

+ (BOOL)ignoreController:(UIViewController *)vc {
    BOOL isIgnore;
    if ([vc isKindOfClass:[UIAlertController class]]) {
        isIgnore = YES;
    } else {
        isIgnore = NO;
    }
    return isIgnore;
}

+ (void)tabBarSelectedWithIndex:(NSUInteger)index {
    UITabBarController *tabBarVC = [self rootVC];
    if ([tabBarVC isKindOfClass:[UITabBarController class]] && tabBarVC && 0 <= index && index < tabBarVC.viewControllers.count) {
        if (tabBarVC.presentedViewController) {
            [tabBarVC dismissViewControllerAnimated:NO completion:nil];
        }
        [tabBarVC.navigationController popToRootViewControllerAnimated:NO];
        
        UINavigationController *selVC = tabBarVC.selectedViewController;
        tabBarVC.selectedIndex = index;
        [selVC popToRootViewControllerAnimated:NO];
    }
}

+ (void)leaveCurrentPage:(UIViewController *)page animated:(BOOL)animated completion:(void (^)(void))completion {
    if (page.navigationController.viewControllers.count >= 2 && [page.navigationController.topViewController isEqual:page]) {
        [page.navigationController popViewControllerAnimated:animated];
        if (completion) {
            completion();
        }
    } else if (page.presentingViewController) {
        [page.presentingViewController dismissViewControllerAnimated:animated completion:^{
            if (completion) {
                completion();
            }
        }];
    } else {
        if (completion) {
            completion();
        }
    }
}

+ (void)leaveCurrentPage:(UIViewController *)page completion:(void (^)(void))completion {
    [self leaveCurrentPage:page animated:YES completion:completion];
}

+ (void)callPhone:(NSString *)phone completion:(void (^)(BOOL))completion {
    NSString *str = [NSString stringWithFormat:@"tel://%@",phone];
    [self openScheme:str handler:completion];
}

+ (void)openScheme:(NSString *)scheme completion:(void (^)(BOOL success))completion {
    [self openScheme:scheme handler:completion];
}


/** 通过scheme调用相应功能
 
 @param scheme 协议
 @param handler 回调处理
 */
+ (void)openScheme:(NSString *)scheme handler:(nullable void (^)(BOOL success))handler {
    UIApplication *application = [UIApplication sharedApplication];
    NSString *str = [self stringAddingPercentEscapesChineseSpace:scheme];
    NSURL *url = [NSString URLWithString_LY:str];
    if (url && [application canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [application openURL:url options:@{} completionHandler:^(BOOL success) {
                if (handler) {
                    handler(success);
                }
            }];
        } else {
            BOOL flag = [[UIApplication sharedApplication] openURL:url];
            if (handler) {
                handler(flag);
            }
        }
    } else {
        if (handler) {
            handler(NO);
        }
    }
}

+ (NSString *)stringAddingPercentEscapesChineseSpace:(NSString *)url {
    if (!url.length) {
        return url;
    }
    
    NSString *regex = @".*[\u4e00-\u9fa5《》（）【】].*";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    __block NSString *urlStr = [url copy];
    BOOL isIllegal = [pre evaluateWithObject:urlStr];
    if (isIllegal) {
        __block NSMutableDictionary *keyValueDict = [NSMutableDictionary dictionary];
        NSString *regex = @"[\u4e00-\u9fa5《》（）【】]";
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:NULL];
        [regular enumerateMatchesInString:urlStr options:NSMatchingReportProgress range:NSMakeRange(0, urlStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *kv = [urlStr substringWithRange:result.range];
                keyValueDict[kv] = [kv stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
        }];
        
        [keyValueDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            urlStr = [urlStr stringByReplacingOccurrencesOfString:key withString:obj];
        }];
    }
    
    return [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
