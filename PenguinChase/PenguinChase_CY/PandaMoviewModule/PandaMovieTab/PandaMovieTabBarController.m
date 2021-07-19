//
//  ORViewController.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/8.
//

#import "PandaMovieTabBarController.h"
#import "PandaMovieTabBar.h"
#import "GNHNavigationController.h"
#import "FilmFactoryUMConfig.h"
#import "PandaMovieDiscoveryViewController.h"
#import "PandaMovieMineViewController.h"
#import "PandaMovieLoginViewController.h"
#import "PenguinChaseHomeViewController.h"
#import "PenguinChaseHuatiViewController.h"
#import "PenguinChaseMessageViewController.h"
#import "ORHotViewController.h"
#import "PandaMovieIndexViewController.h"
#import "PenguinChaseCenterViewController.h"
NSString *const kORDoubleClickTabItemNotification = @"ZYDoubleClickTabItemNotification";
//
@interface PandaMovieTabBarController () <UITabBarControllerDelegate, UINavigationControllerDelegate>
@end

@implementation PandaMovieTabBarController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.delegate = self;
    
    // 设置通知
    [self setupNotifications];
    
    //自定义TabBar
    [self setValue:[[PandaMovieTabBar alloc] init] forKey:@"tabBar"];
    self.tabBar.tintColor = LGDViewBJColor;
    self.tabBar.barTintColor = LGDViewBJColor;
    self.tabBar.translucent = NO;
    // 设置ChildViewController
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:11.0f]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:11.0f]} forState:UIControlStateSelected];
    [self refreshTabBarViewController];

}

#pragma mark - Notification

- (void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(forceLogin:) name:ORAccountForceToLoginNotification object:nil];
}

- (void)appDidEnterBackground:(NSNotification *)notification
{

}

- (void)appWillEnterForeground:(NSNotification *)notification
{
    // 后台切换到前台调自动登录
}

- (void)forceLogin:(NSNotification *)notification
{
    if (![[UIViewController mdf_toppestViewController] isKindOfClass:[PandaMovieLoginViewController class]]) {
        UIViewController *loginVC = [[PandaMovieLoginViewController alloc] init];
        UINavigationController *navVC = [[GNHNavigationController alloc] initWithRootViewController:loginVC];
        navVC.delegate = self;
        navVC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navVC animated:YES completion:nil];
    }
}

#pragma mark - SetupUIs

- (void)refreshTabBarViewController
{
    NSMutableArray *navArray = [NSMutableArray array];

//#import "PenguinChaseHomeViewController.h"
//#import "PenguinChaseHuatiViewController.h"
//#import "PenguinChaseMessageViewController.h"
//#import "PenguinChaseCenterViewController.h"
//#import "PenguinChaseFabuViewController.h"
//#import "PenguinChaseLoginViewController.h"
    
    
    
    // 首页
    PenguinChaseHomeViewController *indexVC = [[PenguinChaseHomeViewController alloc] init];
    UINavigationController *indexNVC = [self FilmFactroyproduceRootNavigationControllerWithVC:indexVC title:@"首页" normalAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} selectAttributes:@{NSForegroundColorAttributeName:LGDMianColor} normalImage:[UIImage imageNamed:@"panda_homenomal"] selectImage:[UIImage imageNamed:@"panda_homesel"]];
    [navArray mdf_safeAddObject:indexNVC];
    
    
    PenguinChaseHuatiViewController *interestVC = [[PenguinChaseHuatiViewController alloc] init];
    UINavigationController *interestNVC = [self FilmFactroyproduceRootNavigationControllerWithVC:interestVC title:@"动态" normalAttributes:@{NSForegroundColorAttributeName:gnh_color_f} selectAttributes:@{NSForegroundColorAttributeName:gnh_color_theme} normalImage:[UIImage imageNamed:@"panda_zonenoaml"] selectImage:[UIImage imageNamed:@"panda_zonesel"]];
    [navArray mdf_safeAddObject:interestNVC];
    
    
    PenguinChaseMessageViewController *MsgVC = [[PenguinChaseMessageViewController alloc] init];
    UINavigationController *MsgtNVC = [self FilmFactroyproduceRootNavigationControllerWithVC:MsgVC title:@"热点" normalAttributes:@{NSForegroundColorAttributeName:gnh_color_f} selectAttributes:@{NSForegroundColorAttributeName:gnh_color_theme} normalImage:[UIImage imageNamed:@"hotredian_nomal"] selectImage:[UIImage imageNamed:@"hotredian_sel"]];
    [navArray mdf_safeAddObject:MsgtNVC];

    
    // 发现
    PandaMovieDiscoveryViewController *matchVC = [[PandaMovieDiscoveryViewController alloc] init];
    UINavigationController *matchNVC = [self FilmFactroyproduceRootNavigationControllerWithVC:matchVC title:@"发现" normalAttributes:@{NSForegroundColorAttributeName:gnh_color_f} selectAttributes:@{NSForegroundColorAttributeName:gnh_color_theme} normalImage:[UIImage imageNamed:@"panda_yuyuenomal"] selectImage:[UIImage imageNamed:@"panda_yuyuesel"]];
    [navArray mdf_safeAddObject:matchNVC];
    
    // 我的
    PenguinChaseCenterViewController *listVC = [[PenguinChaseCenterViewController alloc] init];
    listVC.view.backgroundColor = UIColor.clearColor;
    UINavigationController *listNVC = [self FilmFactroyproduceRootNavigationControllerWithVC:listVC title:@"我的" normalAttributes:@{NSForegroundColorAttributeName:gnh_color_f} selectAttributes:@{NSForegroundColorAttributeName:gnh_color_theme} normalImage:[UIImage imageNamed:@"panda_centernomal"] selectImage:[UIImage imageNamed:@"panda_centersel"]];
    [navArray mdf_safeAddObject:listNVC];

    [self setViewControllers:navArray animated:NO];
    if (navArray.count >= 6) {
        self.moreNavigationController.view.backgroundColor = gnh_color_b;
    }
}

- (UINavigationController *)FilmFactroyproduceRootNavigationControllerWithVC:(UIViewController *)vc title:title normalAttributes:nAttributes selectAttributes:sAttributes normalImage:nImage selectImage:sImage
{
    UIImage *normalImage = [nImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
    if (@available(iOS 13.0, *)) {
        // iOS 13以上
        self.tabBar.tintColor = LGDViewBJColor;
        self.tabBar.unselectedItemTintColor = gnh_color_f;
    } else {
        // iOS 13以下
        [item setTitleTextAttributes:nAttributes forState:UIControlStateNormal];
        [item setTitleTextAttributes:sAttributes forState:UIControlStateSelected];
    }
    vc.tabBarItem = item;
    
    UINavigationController *navVC = [[GNHNavigationController alloc]initWithRootViewController:vc];
    navVC.delegate = self;
    navVC.view.backgroundColor = gnh_color_b;
    return navVC;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

    if ([viewController.tabBarItem.title isEqual:@"动态"]) {
    [FilmFactoryUMConfig analytics:pandazj_tab_dongtai label:@"动态"];
    }else if ([viewController.tabBarItem.title isEqual:@"热点"]){
    [FilmFactoryUMConfig analytics:pandazj_tab_hotpot label:@"热点"];
    }else if ([viewController.tabBarItem.title isEqual:@"发现"]){
    [FilmFactoryUMConfig analytics:pandazj_tab_discovery label:@"发现"];
    }else if ([viewController.tabBarItem.title isEqual:@"我的"]){
    [FilmFactoryUMConfig analytics:pandazj_tab_mine label:@"我的"];

    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([self checkIsDoubleClick:viewController]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kORDoubleClickTabItemNotification object:nil];
    }
    return YES;
}

- (BOOL)checkIsDoubleClick:(UIViewController *)viewController
{
    static UIViewController *lastViewController = nil;
    static NSTimeInterval lastClickTime = 0;
    
    if (lastViewController != viewController) {
        lastViewController = viewController;
        lastClickTime = [NSDate timeIntervalSinceReferenceDate];
        return NO;
    }
    
    NSTimeInterval clickTime = [NSDate timeIntervalSinceReferenceDate];
    if (clickTime - lastClickTime > 0.5) {
        lastClickTime = clickTime;
        return NO;
    }
    lastClickTime = clickTime;
    
    return YES;
}



- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//
    BOOL isHiddenNavBar = ([NSStringFromClass(viewController.class) isEqualToString:@"PandaMovieIndexViewController"] ||
                           [NSStringFromClass(viewController.class) isEqualToString:@"PandaMovieMineViewController"] ||
                           [NSStringFromClass(viewController.class) isEqualToString:@"PandaMovieLoginViewController"] ||
                           [NSStringFromClass(viewController.class) isEqualToString:@"ORHotViewController"] ||
                           [NSStringFromClass(viewController.class) isEqualToString:@"PandaMovieCategoryViewController"] ||
                           [NSStringFromClass(viewController.class) isEqualToString:@"ORHotDetailViewController"] ||
                           [NSStringFromClass(viewController.class) isEqualToString:@"FilmFactoryVideoPlayerViewController"]||
                           [NSStringFromClass(viewController.class) isEqualToString:@"PenguinChaseHomeViewController"] ||
                           [NSStringFromClass(viewController.class) isEqualToString:@"PandaMovieHotDetailViewController"]||
                           [NSStringFromClass(viewController.class) isEqualToString:@"PandaMoVieVideoPlayerViewController"]||
                           [NSStringFromClass(viewController.class) isEqualToString:@"PandaMovieSendingViewController"]||
                           [NSStringFromClass(viewController.class) isEqualToString:@"SDVideoCropViewController"] ||
                           [NSStringFromClass(viewController.class) isEqualToString:@"SDVideoAlbumViewController"]||
                           [NSStringFromClass(viewController.class) isEqualToString:@"SDVideoPreviewViewController"]);
    [navigationController setNavigationBarHidden:isHiddenNavBar animated:NO];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    #ifdef DEBUG
        if (event.subtype == UIEventSubtypeMotionShake && DEBUG) {
            [FilmFactoryUMConfig sharedInstance].um_deubg = ![FilmFactoryUMConfig sharedInstance].um_deubg;
        }
    #else
        if (event.subtype == UIEventSubtypeMotionShake) {
            [FilmFactoryUMConfig sharedInstance].um_deubg = ![FilmFactoryUMConfig sharedInstance].um_deubg;
        }
    #endif
}

@end
