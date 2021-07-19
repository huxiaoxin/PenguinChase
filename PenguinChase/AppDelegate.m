//
//  AppDelegate.m
//  PandaMovie
//
//  Created by zjlk03 on 2021/5/4.
//

#import "AppDelegate.h"
#import "PandaMovieTabBarController.h"
#import "ORShareToolManager.h"
#import "AppDelegate+ORPush.h"
#import "FilmFactoryUMConfig.h"
#import "FilmFactoryAgreementHintsConfig.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "FilmFactoryAQURLManager.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "SSKeychain.h"
#import "SvUDIDTools.h"
#import <BUAdSDK/BUAdSDK.h>
#import <UserNotifications/UserNotifications.h>
#import "FilmFactoryUserInformManager.h"
#import <UMShare/UMShare.h>
#import "FilmFacotryLaunchAdvertManager.h"
#import "FilmFacotryManager.h"
#import "FilmFactoryMenuChannelManager.h"

@interface AppDelegate () <WXApiDelegate>
@property (nonatomic, assign) BOOL allowRotation;  // 是否允许横屏

@end

@implementation AppDelegate

#pragma mark - LifeCycle

+ (AppDelegate *)shareDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initGKNavConfigers];

    // init
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置rootViewController
    [self setupTabBarViewController];
    
    [self setUpFixiOS11];
    // 设置穿山甲SDK
    [self configBUAdSDK];

    // 设置辅助项
    [self setupConfig];

    // 初始化ShareSDK
    [[ORShareToolManager sharedInstance] registerShareSDK];

    //友盟统计
    [FilmFactoryUMConfig sharedInstance];

    // 注册推送
    [self registPushWithConfigData:launchOptions];
    
    // 隐私协议弹框
//    [FilmFactoryAgreementHintsConfig config];
    
    // 配置用户数据
    [FilmFactoryUserInformManager sharedInstance];

    // 配置开屏广告
    [FilmFacotryLaunchAdvertManager sharedInstance];

    // 乐播投屏
    [FilmFacotryManager newLBManager];
    
    [FilmFactoryMenuChannelManager sharedInstance];

    return YES;
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

#pragma mark - setupData

- (void)setupTabBarViewController
{
    PenguinChase_BaseTabbarViewController *tabBarViewController = [[PenguinChase_BaseTabbarViewController alloc] init];
    self.window.windowLevel = UIWindowLevelNormal;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarViewController;
    _tabBarViewController = tabBarViewController;
    [self.window makeKeyAndVisible];

}

- (void)setupConfig
{

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    // SVProgress 样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMaximumDismissTimeInterval:1.0f];
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(begainFullScreen) name:kUIDeviceOrientationFullScreen object:nil];//进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:kUIDeviceOrientationendFullScreen object:nil];//退出全屏
}

- (void)configBUAdSDK
{
    
    [BUAdSDKManager setAppID:BUAdSDKManagerKey];
    [BUAdSDKManager setIsPaidApp:NO];
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
}

#pragma mark - AppDelegate

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
        // 其他SDK的回调
        if ([WXApi handleOpenUniversalLink:userActivity delegate:self]) {
            return YES;
        }
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([WXApi handleOpenURL:url delegate:self]) {
            return YES;
        }
    }

    return result;
}

#pragma mark - UIDevice Orientation

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskLandscape;
    }
    if (self.isShouldOrientationMaskAll) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

// 进入全屏
- (void)begainFullScreen
{
    self.allowRotation = YES;
    
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

// 退出全屏
- (void)endFullScreen
{
    self.allowRotation = NO;
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
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
@end

