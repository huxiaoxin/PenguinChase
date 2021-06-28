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
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [NSClassFromString(@"PenguinChase_BaseTabbarViewController") new];

    return YES;
}
-(void)initGKNavConfigers{
    GKNavigationBarConfigure *DongwangConfigers = [GKNavigationBarConfigure sharedInstance];
    [DongwangConfigers setupDefaultConfigure];
    DongwangConfigers.backgroundColor = [UIColor whiteColor];
    DongwangConfigers.backStyle = GKNavigationBarBackStyleBlack;
    DongwangConfigers.titleColor = [UIColor blackColor];
    DongwangConfigers.titleFont = [UIFont systemFontOfSize:15];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
   
}



@end
