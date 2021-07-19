//
//  ORKitMacros.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/11/1.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GNHWeakObj(o)   __weak  __typeof(o) weak##o = o;
#define GNHStrongObj(o) __strong __typeof(o) o = weak##o
#define GNHWeakSelf __weak __typeof(&*self)weakSelf = self;
#define ssWeak(obj,x) __weak typeof(obj) x = obj;

#define gnh_dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define gnh_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define kGNHNavigationBarHeight (ORKitMacros.navigationBarHeight)
#define kGNHStatusBarHeight (ORKitMacros.statusBarHeight)
#define kGNHTabBarHeight (ORKitMacros.tabBarHeight)

#define ORNetworkDownloadConfig @"networkDownloadConfig"
#define ORSearchkeywordsKey @"searchkeywordsKey"
#define ORForbidContentKey @"forbidContentKey"
#define ORUserDefaults ([NSUserDefaults standardUserDefaults])
#define ORShareAccountComponent [FilmFactoryAccountComponent sharedInstance]

// 适配比例
#define ADAPTATIONRATIO     kScreenWidth / 750.0f

@interface ORKitMacros : NSObject

@property (nonatomic, assign, readonly, class) CGFloat navigationBarHeight;
@property (nonatomic, assign, readonly, class) CGFloat statusBarHeight;
@property (nonatomic, assign, readonly, class) CGFloat tabBarHeight;
@property (nonatomic, assign, readonly, class) CGFloat iphoneXSafeHeight;

@end
