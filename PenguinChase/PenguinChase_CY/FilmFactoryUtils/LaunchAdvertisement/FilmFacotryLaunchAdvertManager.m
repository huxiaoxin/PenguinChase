
#import "FilmFacotryLaunchAdvertManager.h"
#import <BUAdSDK/BUAdSDK.h>

@interface FilmFacotryLaunchAdvertManager () <BUSplashAdDelegate,BUNativeExpressFullscreenVideoAdDelegate>
@property (nonatomic, strong)  BUSplashAdView      * splashView; // 穿山甲开屏广告
@property (nonatomic, strong)  BUNativeExpressFullscreenVideoAd *fullscreenAd; //穿山甲全屏广告
@property(nonatomic,strong)    UIView              * splashBackView;
@property(nonatomic,strong)    UIImageView         * LogoImgView;
@property(nonatomic,strong)    UILabel             * Infolb;
@end

@implementation FilmFacotryLaunchAdvertManager

#pragma mark - Init

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(appJumpToVideoDetail:) name:@"appJumpToVideoDetail" object:nil];
        [self setupData];
    }
    return self;
}

- (UIView *)splashBackView{
    if (!_splashBackView) {
        _splashBackView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _splashBackView.backgroundColor = [UIColor whiteColor];
    }
    return _splashBackView;
}
- (UILabel *)Infolb{
    if (!_Infolb) {
        _Infolb = [[UILabel alloc]init];
        _Infolb.text = @"企鹅追剧";
        _Infolb.font = zy_fontSize30;
        _Infolb.textColor = LGDBLackColor;
    }
    return _Infolb;
}
- (UIImageView *)LogoImgView{
    if (!_LogoImgView) {
        _LogoImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _LogoImgView.image = [UIImage imageNamed:@"homelogo"];
    }
    return _LogoImgView;
}
#pragma mark - setupData

- (void)setupData
{
    // 展示穿山甲广告
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:BUAdSDKManagerSortId frame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * (4/5.0))];
    splashView.delegate = self;
    splashView.tolerateTimeout = 5.0f;
    self.splashView = splashView;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    [splashView loadAdData];
//    [keyWindow.rootViewController.view addSubview:splashView];
    [keyWindow.rootViewController.view addSubview:self.splashBackView];
    [_splashBackView addSubview:splashView];
    [_splashBackView addSubview:self.LogoImgView];
    [_splashBackView addSubview:self.Infolb];
    splashView.rootViewController = keyWindow.rootViewController;
    [_LogoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_splashBackView);
        make.top.mas_equalTo(splashView.mas_bottom).offset(RealWidth(20));
        make.size.mas_equalTo(CGSizeMake(RealWidth(50), RealWidth(50)));
    }];
  
    [_Infolb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_splashBackView);
        make.top.mas_equalTo(_LogoImgView.mas_bottom).offset(RealWidth(5));
        make.height.mas_equalTo(RealWidth(30));
    }];
}

// 集成全屏视频广告
- (void)setUpFullScrrenData
{
    BUNativeExpressFullscreenVideoAd *fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:BUAdSDKManagerScreenSortId];
    fullscreenAd.delegate = self;
    [fullscreenAd loadAdData];
    self.fullscreenAd = fullscreenAd;

    [fullscreenAd loadAdData];
}



#pragma mark - notification

- (void)appDidEnterBackground:(NSNotification *)notification
{
    
}

- (void)appWillEnterForeground:(NSNotification *)notification
{
    // 后台切换到前台调自动登录
    [self setupData];
}

- (void)appJumpToVideoDetail:(NSNotification *)notification {
    [self setUpFullScrrenData];
    [FilmFactoryUMConfig analytics:pandazj_video_play label:@"影视播放"];
}

#pragma mark - 穿山甲SDK  BUNativeExpressFullscreenVideoAdDelegate

/**
 This method is called when video ad material loaded successfully.
 */
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    // 加载成功
}

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error
{
    // 加载失败
}

/**
 This method is called when video cached successfully.
 For a better user experience, it is recommended to display video ads at this time.
 And you can call [BUNativeExpressFullscreenVideoAd showAdFromRootViewController:].
 */
- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    //全屏加载成功
    if (self.fullscreenAd) {
        UIViewController *rootViewController = [UIViewController mdf_toppestViewController];
        [self.fullscreenAd showAdFromRootViewController:rootViewController];
    }
}

/**
 This method is called when video ad slot will be showing.
 */
- (void)nativeExpressFullscreenVideoAdWillVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    // 广告将展示

    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

/**
 This method is called when video ad slot has been shown.
 */
- (void)nativeExpressFullscreenVideoAdDidVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    
}

/**
 This method is called when video ad is clicked.
 */
- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    // 点击广告
}

/**
 This method is called when the user clicked skip button.
 */
- (void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    // 点击跳过
    self.fullscreenAd = nil;
    fullscreenVideoAd = nil;
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

/**
 This method is called when video ad is about to close.
 */
- (void)nativeExpressFullscreenVideoAdWillClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    // 广告将关闭
    self.fullscreenAd = nil;
    fullscreenVideoAd = nil;
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

/**
 This method is called when video ad is closed.
 */
- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd
{
    // 广告将关闭
    self.fullscreenAd = nil;
    fullscreenVideoAd = nil;
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error
{
    
}

/**
This method is used to get the type of nativeExpressFullScreenVideo ad
 */
- (void)nativeExpressFullscreenVideoAdCallback:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd withType:(BUNativeExpressFullScreenAdType) nativeExpressVideoAdType
{
    
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressFullscreenVideoAdDidCloseOtherController:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd interactionType:(BUInteractionType)interactionType
{
    
}


#pragma mark - 穿山甲SDK  BUSplashAdDelegate

/**
This method is called when splash ad material loaded successfully.
*/
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd
{
    // 广告加载成功
}

/**
This method is called when splash ad material failed to load.
@param error : the reason of error
*/
- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error
{
    // 加载失败
    [self.splashView removeFromSuperview];
    [self.splashBackView removeFromSuperview];
    
    self.splashView = nil;
    self.splashBackView = nil;
}

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillVisible:(BUSplashAdView *)splashAd
{
    // 广告将展示
    
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(BUSplashAdView *)splashAd
{
    // 点击广告
}

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(BUSplashAdView *)splashAd
{
    // 关闭广告
    [self.splashView removeFromSuperview];
    [self.splashBackView removeFromSuperview];
    
    self.splashView = nil;
    self.splashBackView = nil;
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}


/**
 This method is called when splash ad is about to close.
 */
- (void)splashAdWillClose:(BUSplashAdView *)splashAd
{
    // 广告将关闭
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType
{
    
}

/**
 This method is called when spalashAd skip button  is clicked.
 */
- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd
{
    // 点击跳过
    [self.splashView removeFromSuperview];
    [self.splashBackView removeFromSuperview];
    
    self.splashView = nil;
    self.splashBackView = nil;
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

/**
 This method is called when spalashAd countdown equals to zero
 */
- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd
{
    // 时间到了
    [self.splashView removeFromSuperview];
    [self.splashBackView removeFromSuperview];

    self.splashView = nil;
    self.splashBackView = nil;
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}


#pragma mark - Handle Data


#pragma mark - Properties


@end
