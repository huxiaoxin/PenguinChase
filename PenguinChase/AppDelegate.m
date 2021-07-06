//
//  AppDelegate.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/24.
//

#import "AppDelegate.h"
#import <IQKeyboardManager-umbrella.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initGKNavConfigers];
    [self setUpFixiOS11];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [NSClassFromString(@"PenguinChase_BaseTabbarViewController") new];

    return YES;
}
#pragma mark - 适配
- (void)setUpFixiOS11 {
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}
-(void)initGKNavConfigers{
    GKNavigationBarConfigure *DongwangConfigers = [GKNavigationBarConfigure sharedInstance];
    [DongwangConfigers setupDefaultConfigure];
    DongwangConfigers.backgroundColor = [UIColor whiteColor];
    DongwangConfigers.backStyle = GKNavigationBarBackStyleBlack;
    DongwangConfigers.titleColor = [UIColor blackColor];
    DongwangConfigers.titleFont = [UIFont boldSystemFontOfSize:18];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
   
}



@end
