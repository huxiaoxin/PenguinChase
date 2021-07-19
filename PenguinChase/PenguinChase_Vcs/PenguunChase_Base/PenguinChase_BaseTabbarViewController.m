

#import "PenguinChase_BaseTabbarViewController.h"
#import "CHTabBar.h"
#import "CoreAnimationEffect.h"

#import "PenguinChaseHomeViewController.h"
#import "PenguinChaseHuatiViewController.h"
#import "PenguinChaseMessageViewController.h"
#import "PenguinChaseCenterViewController.h"
#import "PenguinChaseFabuViewController.h"
#import "PenguinChaseLoginViewController.h"
#import "ORHotViewController.h"
#import "PandaMovieLoginViewController.h"
@interface PenguinChase_BaseTabbarViewController ()<UITabBarControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)UITabBarItem *lastItem; // 标记上一次点击的TabBarItem
@end

@implementation PenguinChase_BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(forceLogin:) name:ORAccountForceToLoginNotification object:nil];

    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    CHTabBar *tabbar = [[CHTabBar alloc] init];
    tabbar.translucent = NO;
    tabbar.barTintColor = [UIColor whiteColor];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:LGDGaryColor} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:LGDMianColor} forState:UIControlStateSelected];
    NSMutableArray *titleArr;
    NSMutableArray *imageNormalArr;
    NSMutableArray *imageSelectedArr;
    NSArray *controArray;
    titleArr = [NSMutableArray arrayWithObjects:@"首页",@"分类", @"视频",@"消息",@"我的", nil];
    imageNormalArr = [NSMutableArray arrayWithObjects:@"shouyeHom_nomal",@"fenlei_nomal",@"duanshipin_nomal",@"xiaoxi_nomal",@"gerenzhongxin_nomal", nil];
    imageSelectedArr = [NSMutableArray arrayWithObjects:@"shouyeHom_sel",@"fenlei_sel",@"duanshipin_sel",@"xiaoxi_sel",@"gerenzhongxin_sel", nil];
    controArray = @[[PenguinChaseHomeViewController new], [PenguinChaseHuatiViewController new], [ORHotViewController new],[PenguinChaseMessageViewController new], [PenguinChaseCenterViewController new]];
    for (int i = 0; i < titleArr.count; i++) {
        UINavigationController *nav = [UINavigationController rootVC:controArray[i] translationScale:YES];
        [self addChildViewController:nav andTitle:titleArr[i] image:imageNormalArr[i] selectImage:imageSelectedArr[i]];
    }
    self.selectedIndex =  0;
}
- (void)forceLogin:(NSNotification *)notification
{
    if (![[UIViewController mdf_toppestViewController] isKindOfClass:[PandaMovieLoginViewController class]]) {
        UIViewController *loginVC = [[PandaMovieLoginViewController alloc] init];
        UINavigationController *navVC = [UINavigationController rootVC:loginVC translationScale:NO];
        navVC.delegate = self;
        navVC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navVC animated:YES completion:nil];
    }
}

#pragma mark - 控制器跳转拦截
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UINavigationController * baseNav  = (UINavigationController *)viewController;
        if ([NSStringFromClass(baseNav.topViewController.class) isEqualToString:@"PenguinChaseMessageViewController"])
    {
        
        if ([FilmFactoryAccountComponent checkLogin:YES]) {

            return YES;
        }else{
            return NO;
        }
    }
    else{
        
        return YES;
    }
}
-(void)addChildViewController:(UIViewController *)vc andTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage{
    vc.tabBarItem.title = title;
    UIImage *rootNotImage;
    UIImage *rootSelectImage;
    rootNotImage = [UIImage imageNamed:image];
    rootSelectImage = [UIImage imageNamed:selectImage];
    
    vc.tabBarItem.image = [rootNotImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    vc.tabBarItem.selectedImage = [rootSelectImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -1);
    CGFloat tabbarIItemMakeFloat = [NSString isBlankString:title] ? 0: 0;
    
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-tabbarIItemMakeFloat, 0, tabbarIItemMakeFloat, 0);
    //添加到
    [self addChildViewController:vc];
}
#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
}
#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    return tabBarButton;
}
#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            [CoreAnimationEffect showCAKeyframeAnimationsForView:imageView keyPath:@"transform.scale" values1:1 values2:1.1 values3:.9 values4:1 duration:.3 repatCount:1];
        }
    }
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

