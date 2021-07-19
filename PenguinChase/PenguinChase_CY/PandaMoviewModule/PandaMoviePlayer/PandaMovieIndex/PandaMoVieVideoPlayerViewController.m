

#import "PandaMoVieVideoPlayerViewController.h"
#import "PandaMovieVideoRecommendTableViewCell.h"
#import "PandaMovieVideoDetailTableViewCell.h"
#import <SJVideoPlayer/SJVideoPlayer.h>
#import <SJUIKit/NSAttributedString+SJMake.h>
#import <SJBaseVideoPlayer/SJPlaybackRecordSaveHandler.h>
#import <AVKit/AVPictureInPictureController.h>
#import "PandaMovieVideoPlayerDataModel.h"
#import "PandaMovieVideoIntroView.h"
#import "PandaMovieVideoEpisodesView.h"
#import "PandaMoviewAddFavoriteDataModel.h"
#import "PandaMovieDeleteFavoriteDataModel.h"
#import "FilmFacotryVideoReportManager.h"
#import "PandaMovieH5ViewController.h"
#import "PandaMovieChooseSourceView.h"
#import "ORShareTool.h"
#import "ORShareReportDataModel.h"
#import "PandaMovieVideoRecommendDataModel.h"
#import "PandaMovieThrowScreenViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "AppDelegate.h"

@interface PandaMoVieVideoPlayerViewController () <BUNativeExpressBannerViewDelegate,BUNativeExpressFullscreenVideoAdDelegate>

@property (nonatomic, strong) PandaMovieVideoPlayerDataModel *videoPlayerDataModel; // 视频详情
@property (nonatomic, strong) PandaMovieVideoRecommendDataModel *videoRecommendDataModel; // 推荐视频数据
@property (nonatomic, strong) PandaMoviewAddFavoriteDataModel *addFavoriteDataModel; // 添加收藏
@property (nonatomic, strong) PandaMovieDeleteFavoriteDataModel *deleteFavoriteDataModel; // 取消收藏
@property (nonatomic, strong) ORShareReportDataModel *shareReportDataModel; // 分享上报

@property (nonatomic, strong) FilmFacotryVideoModel *videoModel;
@property (nonatomic, strong) NSMutableArray <__kindof FilmFacotryVideoModel *> *videoItems;

@property (nonatomic, strong) UIView *playerContainerView;
@property (nonatomic, strong) SJVideoPlayer *player;
@property (nonatomic, strong) UIButton *playButton; // 播放按钮
@property (nonatomic, strong) UIImageView *playerBackImageView; // 默认图

@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong) UIButton *preTagButton;

@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, strong) PandaMovieChooseSourceView *chooseSourceView;
@property (nonatomic, strong) UIButton *dropdownBtn;

@property (nonatomic, assign) NSString *currentEpisode; // 当前是第几集
@property (nonatomic, assign) NSInteger watchSeconds; // 观看到位置
@property (nonatomic, strong) UILabel *tipsLabel; // 提示

@property (nonatomic, strong) NSString *currentSourceName;
@property (nonatomic, assign) BOOL isChooseSource; // 是否切换数据源

@property (nonatomic, strong) BUNativeExpressBannerView *bannerAdView;  // banner 广告

//新版插屏广告
@property(nonatomic,strong) BUNativeExpressFullscreenVideoAd * fullscreenAd;

@end

@implementation PandaMoVieVideoPlayerViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    
    [self setupData];

}
#pragma mark--新版插屏广告初始化
-(void)setUpTableSqualData{
    self.fullscreenAd =  [[BUNativeExpressFullscreenVideoAd alloc]initWithSlotID:BUAdSDKManagerTablePlaqueId];
    self.fullscreenAd.delegate = self;
    [self.fullscreenAd loadAdData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isShouldOrientationMaskAll = YES;

    GNHWeakSelf;
    // 查询最后更新的一集
    [self.videoItems enumerateObjectsUsingBlock:^(__kindof FilmFacotryVideoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.idStr isEqualToString:self.videoId] && [obj.type isEqualToString:self.videotype]) {
            weakSelf.currentEpisode = obj.episode;
            weakSelf.watchSeconds = obj.watchSeconds;
        }
    }];
    
    // 视频详情
    [self.videoPlayerDataModel fetchVideoDetialWithParams:self.videoId videoType:self.videotype sourceName:self.currentSourceName episode:self.currentEpisode];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.player vc_viewDidAppear];
    
    // 记录观看记录
    [self storeWatchRecord];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.player vc_viewWillDisappear];
    
    self.isShouldOrientationMaskAll = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.player vc_viewDidDisappear];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - setupUI

- (void)setupUI
{
    self.view.backgroundColor = UIColor.blackColor;
    
    UIView *playerContainerView = [UIView ly_ViewWithColor:UIColor.blackColor];
    [self.view addSubview:playerContainerView];
    [playerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(ORKitMacros.statusBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_offset((212.5 * kScreenWidth)/375.0);
    }];
    self.playerContainerView = playerContainerView;
    
    // 添加默认图
    UIImageView *playerBackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pandaMovie_thub_Icon_defaultr"]];
    [self.view addSubview:playerBackImageView];
    [playerBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.playerContainerView);
        make.size.mas_equalTo(CGSizeMake(113.5, 34));
    }];
    self.playerBackImageView = playerBackImageView;
    self.playerBackImageView.hidden = YES;
    
    // 中间添加播放按钮
    UIButton *playButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_casue_icon" selecteImageName:@"pandaMoview_play_icon" target:self selector:@selector(playerAction:)];
    [self.view addSubview:playButton];
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(playerContainerView);
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
    }];
    self.playButton = playButton;
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isKindOfClass:[PandaMovieVideoDetailItem class]]) {
        return [PandaMovieVideoDetailTableViewCell class];
    } else if ([item isKindOfClass:[PandaMovieVideoRecommendItem class]]) {
        return [PandaMovieVideoRecommendTableViewCell class];
    }
    
    return nil;
}

- (void)configForCell:(GNHBaseTableViewCell *)cell item:(id)item
{
    if ([item isKindOfClass:[PandaMovieVideoRecommendItem class]]) {
        GNHWeakSelf;
        PandaMovieVideoRecommendTableViewCell *videoRecommedCell = (PandaMovieVideoRecommendTableViewCell *)cell;
        videoRecommedCell.recommendItemCallBack = ^(PandaMovieVideoBaseItem * _Nonnull dataItem) {
            // 记录观看记录，存储前一次观看记录
            [weakSelf storeWatchRecord];
            
            // 刷新当前播放器
            weakSelf.videoId = dataItem.idStr;
            weakSelf.videotype = dataItem.type;
            weakSelf.coverUrl = dataItem.coverImg;
                        
            // 视频详情
            [weakSelf.videoPlayerDataModel fetchVideoDetialWithParams:weakSelf.videoId videoType:weakSelf.videotype sourceName:nil episode:nil];
            
            [weakSelf deallocChooseView];
            
            //开启广告
            [[NSNotificationCenter defaultCenter] postNotificationName:@"appJumpToVideoDetail" object:nil];
        };
    }
}

#pragma mark - setupData

- (void)setupData
{
    self.fd_prefersNavigationBarHidden = YES;

    CGFloat orgin_y = ORKitMacros.statusBarHeight + (212.5 * kScreenWidth)/375.0;
    self.tableView.frame = CGRectMake(0, orgin_y, kScreenWidth, kScreenHeight - orgin_y);
    self.tableView.backgroundColor = gnh_color_b;
    
    // 观看历史记录
    self.videoItems = [[FilmFacotryVideoReportManager sharedInstance] videoItems];
    
    // 初始化播放器
    SJVideoPlayer.updateResources(^(id<SJVideoPlayerControlLayerResources>  _Nonnull resources) {
        resources.placeholder = [UIImage imageNamed:@"placeholder"];
        resources.progressThumbSize = 8;
        resources.progressTrackColor = [UIColor colorWithWhite:0.3 alpha:1];
        resources.progressBufferColor = [UIColor colorWithWhite:0.6 alpha:1];
        resources.progressTraceColor = gnh_color_theme;
        resources.progressThumbColor = gnh_color_theme;

        resources.bottomIndicatorTraceColor = UIColor.clearColor;
        resources.bottomIndicatorTrackColor = UIColor.clearColor;

        resources.backImage = [UIImage imageNamed:@"pandaMoview_leff_white_arrow"];
        resources.fullscreenImage = [UIImage imageNamed:@"pandaMoview_FullScreen_icon"];
        resources.pauseImage = [UIImage imageNamed:@"pandaMoview_casue_icon"];
        resources.playImage = [UIImage imageNamed:@"pandaMoview_play_icon"];
        resources.lockImage = [UIImage imageNamed:@"pandaMoview_lock_icon"];
        resources.unlockImage = [UIImage imageNamed:@"pandaMoview_unlock_icon"];
    });
    
    // 建立记录模型
    FilmFacotryVideoModel *videoModel = [[FilmFacotryVideoModel alloc] init];
    videoModel.idStr = self.videoId;
    videoModel.type = self.videotype;
    self.videoModel = videoModel;
    
    // 配置数据
    GNHTableViewSectionObject *sectionObject = [[GNHTableViewSectionObject alloc] init];
    self.sections = [@[sectionObject] mutableCopy];
    
    //开启广告
    [[NSNotificationCenter defaultCenter] postNotificationName:@"appJumpToVideoDetail" object:nil];
    
}

- (void)initPlayer
{
    SJVideoPlayer *player = [SJVideoPlayer player];
    self.player = player;
    player.pauseWhenAppDidEnterBackground = NO;
    player.controlLayerAppearManager.interval = 5; // 设置控制层隐藏间隔
    player.resumePlaybackWhenAppDidEnterForeground = YES;
    if (@available(iOS 14.0, *)) {
        player.defaultEdgeControlLayer.automaticallyShowsPictureInPictureItem = NO;
    } else {
        // Fallback on earlier versions
    }
    player.defaultEdgeControlLayer.showsMoreItem = NO;
    [self.playerContainerView addSubview:player.view];
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    // 配置底部进度条
    [player.defaultEdgeControlLayer.bottomAdapter exchangeItemForTag:SJEdgeControlLayerBottomItem_DurationTime withItemForTag:SJEdgeControlLayerBottomItem_Progress];
    [player.defaultEdgeControlLayer.bottomAdapter removeItemForTag:SJEdgeControlLayerBottomItem_Play];
    [player.defaultEdgeControlLayer.bottomAdapter removeItemForTag:SJEdgeControlLayerBottomItem_Separator];
    SJEdgeControlButtonItem *item = (SJEdgeControlButtonItem *)[self.player.defaultEdgeControlLayer.bottomAdapter itemForTag:SJEdgeControlLayerBottomItem_CurrentTime];
    item.insets = SJEdgeInsetsMake(12.5, 0);
    [player.defaultEdgeControlLayer.bottomAdapter reload];
    
    // 长按进度
    // 1. 开启所有手势
    player.gestureControl.supportedGestureTypes |= SJPlayerGestureTypeMask_LongPress;
    // 2. 设置长按播放器界面时的播放速率
    player.rateWhenLongPressGestureTriggered = 2.0;
//    player.useFitOnScreenAndDisableRotation = YES;
    [player setFitOnScreen:NO];
    
    GNHWeakSelf;
    player.controlLayerAppearObserver.appearStateDidChangeExeBlock = ^(id<SJControlLayerAppearManager>  _Nonnull mgr) {
        weakSelf.playButton.hidden = !mgr.isAppeared;
        
        if (mgr.isAppeared) {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.tipsLabel.alpha = 1.0;
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.tipsLabel.alpha = 0.0;
            }];
        }
    };
    
    // 全屏监控
    player.rotationObserver.rotationDidEndExeBlock = ^(id<SJRotationManager>  _Nonnull mgr) {
        if (!mgr.isFullscreen) {
            [weakSelf.tableView reloadData];
        }
    };
    if (player.autoplayWhenSetNewAsset) {
        self.playButton.hidden = YES;
    }
    
    SJEdgeControlButtonItem *airplayItem = [[SJEdgeControlButtonItem alloc] initWithImage:[UIImage imageNamed:@"player_tv"] target:self action:@selector(throwScreen:) tag:10000];
    airplayItem.insets = SJEdgeInsetsMake(20, 12);
    [_player.defaultEdgeControlLayer.topAdapter addItem:airplayItem];
    [_player.defaultEdgeControlLayer.topAdapter reload];
}

- (void)configData
{
    // 播放视频
    NSString *videoUrl = self.videoPlayerDataModel.videoDetailItem.source.videoUrl;
    self.currentSourceName = self.videoPlayerDataModel.videoDetailItem.source.sourceName;

    if (self.videoPlayerDataModel.videoDetailItem.source.redirectType) {
        // 跳转第三方
        self.playButton.hidden = NO;
        self.playButton.selected = YES;
        self.playerBackImageView.hidden = NO;
        [self.view bringSubviewToFront:self.playerBackImageView];
        [self.view bringSubviewToFront:self.playButton];
        self.playButton.selected = YES;
        
        if (self.player) {
            [self.player pause];
            [self.player.view removeFromSuperview];
            self.player = nil;
        }
    } else {
        self.playButton.selected = NO;
        self.playerBackImageView.hidden = YES;
        
        if (!self.player) {
            [self initPlayer];
        }
        [self configPlayer:videoUrl];
    }

    // 刷新视频详情
    [self configTableHeaderView];
    
    // 移除多片源选择
    [self.chooseSourceView removeFromSuperview];
    self.chooseSourceView = nil;
}

- (void)configPlayer:(NSString *)videoUrl
{
    GNHWeakSelf;
    // 播放
    SJVideoPlayerURLAsset *asset = [SJVideoPlayerURLAsset.alloc initWithURL:videoUrl.urlWithString startPosition:self.watchSeconds];
    // - 为将要播放的 asset 关联一个 record
    asset.attributedTitle = [NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol>  _Nonnull make) {
        make.append(weakSelf.videoPlayerDataModel.videoDetailItem.videoName);
        make.textColor(UIColor.whiteColor);
    }];
    
    // - 进行播放
    self.player.URLAsset = asset;
    // - 如果之前播放过, 这里提示一下用户从上次的位置进行播放
    
    if (self.watchSeconds > 0) {
        [self.player.prompt show:[NSAttributedString sj_UIKitText:^(id<SJUIKitTextMakerProtocol>  _Nonnull make) {
            make.append([NSString stringWithFormat:@"上次观看到 %@", [self.player stringForSeconds:self.watchSeconds]]);
            make.textColor(UIColor.whiteColor);
        }] duration:3];
    }
    self.player.rotationObserver.rotationDidStartExeBlock = ^(id<SJRotationManager>  _Nonnull mgr) {
        __strong typeof(weakSelf) self = weakSelf;
        if ( !self ) return ;
        
#ifdef DEBUG
        NSLog(@"%d \t %s", (int)__LINE__, __func__);
#endif
    };
    
    // 自动播放下一集
    // 播放完毕后, 重新播放. 也就是循环播放
    self.player.playbackObserver.playbackDidFinishExeBlock = ^(__kindof SJBaseVideoPlayer * _Nonnull player) {
        // 播放第几集
        UIButton *selectBtn = [weakSelf.containerScrollView viewWithTag:weakSelf.preTagButton.tag + 1];
        if (selectBtn) {
            [weakSelf.containerScrollView scrollRectToVisible:selectBtn.frame animated:YES];

            [weakSelf episodesTagAction:selectBtn];
        }
    };
        
    // 步骤3: 初始化保存管理类
    SJPlaybackRecordSaveHandler *handler = SJPlaybackRecordSaveHandler.shared;
    // 指定保存的时机, handler 将自动进行保存
    handler.events = SJPlayerEventMaskAll;
    
    [self.tipsLabel removeFromSuperview];
    UILabel *tipsLabel = [UILabel ly_LabelWithTitle:@"请勿相信此视频中的任何广告" font:zy_mediumSystemFont12 titleColor:gnh_color_b];
    [self.playerContainerView addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playerContainerView).offset(12.0f);
        make.bottom.equalTo(self.playerContainerView).offset(-5.0f);
    }];
    self.tipsLabel = tipsLabel;
    self.tipsLabel.alpha = 0.0;
    [UIView animateWithDuration:0.35 animations:^{
        self.tipsLabel.alpha = 1.0;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tipsLabel.alpha = 0.0;
    });
}

- (void)configTableHeaderView
{
    GNHWeakSelf;
    CGFloat height = 132.0f;
    
    NSString *sourceName = self.videoPlayerDataModel.videoDetailItem.source.sourceName;
    NSArray *episodes = self.videoPlayerDataModel.videoDetailItem.episodes[sourceName];
    self.currentEpisode = self.videoPlayerDataModel.videoDetailItem.episode;
    if (episodes.count) {
        // 选集
        height = 215.0f;
    }
    UIView *headerView = [UIView ly_ViewWithColor:gnh_color_b];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, height + 150);
    
    // 视频名称
    UILabel *videoNameLabel = [UILabel ly_LabelWithTitle:self.videoPlayerDataModel.videoDetailItem.videoName font:zy_heavySystemFont(20.0f) titleColor:gnh_color_k];
    [headerView addSubview:videoNameLabel];
    [videoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(19.5f);
        make.left.mas_offset(13.0f);
        make.right.equalTo(headerView).offset(-50.0f);
        make.height.mas_offset(19.0f);
    }];

    // 视频类型描述
    NSString *descTypeStr = [NSString stringWithFormat:@"%.1f", self.videoPlayerDataModel.videoDetailItem.score];
    if (self.videoPlayerDataModel.videoDetailItem.childTypeCh.length) {
        descTypeStr = [descTypeStr stringByAppendingString:@" / "];
        descTypeStr = [descTypeStr stringByAppendingString:self.videoPlayerDataModel.videoDetailItem.childTypeCh];
    }

    UILabel *descTypeLabel = [UILabel ly_LabelWithTitle:descTypeStr font:zy_mediumSystemFont14 titleColor:gnh_color_s];
    [headerView addSubview:descTypeLabel];
    [descTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(videoNameLabel.mas_bottom).offset(16.0f);
        make.left.equalTo(headerView).offset(15.0f);
        make.height.mas_offset(13.0f);
    }];
    
    UIButton *introBtn = [UIButton ly_ButtonWithTitle:@"简介" titleColor:gnh_color_s font:zy_mediumSystemFont14 target:self selector:@selector(introBtnAction:)];
    [introBtn setImage:[UIImage imageNamed:@"pandamoview_gray_arrow"] forState:UIControlStateNormal];
    [introBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [introBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [headerView addSubview:introBtn];
    [introBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-10.0f);
        make.centerY.equalTo(descTypeLabel);
        make.width.mas_offset(70.0f);
    }];
    
    // 版权方
    UIImageView *logoImageView = [UIImageView ly_ImageViewWithImageName:nil];
    [headerView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descTypeLabel.mas_bottom).offset(20.0f);
        make.left.equalTo(headerView).offset(14.0f);
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0));
    }];
    [logoImageView setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [logoImageView sd_setImageWithURL:self.videoPlayerDataModel.videoDetailItem.source.icon.urlWithString];
    [logoImageView mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        [weakSelf chooseSource];
    }];
    
    UILabel *copyrighLabel = [UILabel ly_LabelWithTitle:self.videoPlayerDataModel.videoDetailItem.source.sourceName font:zy_mediumSystemFont14 titleColor:gnh_color_s];
    [headerView addSubview:copyrighLabel];
    [copyrighLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.videoPlayerDataModel.videoDetailItem.source.icon.length) {
            make.left.equalTo(logoImageView.mas_right).offset(3.5);
        } else {
            make.left.equalTo(headerView).offset(14.0f);
        }
        make.centerY.equalTo(logoImageView);
    }];
    [copyrighLabel setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [copyrighLabel mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        [weakSelf chooseSource];
    }];
    
    UIButton *dropdownBtn = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_pull_download_icon" selecteImageName:@"pandaMoview_famous_icon" target:self selector:@selector(chooseSource)];
    [headerView addSubview:dropdownBtn];
    [dropdownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(copyrighLabel);
        make.left.equalTo(copyrighLabel.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0));
    }];
    self.dropdownBtn = dropdownBtn;
        
    // 下载
    UIButton *downloadBtn = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_notDownload_icon" selecteImageName:@"pandaMoview_dowud_icons" target:self selector:@selector(downloadAction:)];
    [headerView addSubview:downloadBtn];
    [downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-8.0f);
        make.centerY.equalTo(copyrighLabel);
        make.size.mas_equalTo(CGSizeMake(29, 29));
    }];
    downloadBtn.selected = self.videoPlayerDataModel.videoDetailItem.download;
    
    // 分享
    UIButton *shareBtn = [UIButton ly_ButtonWithNormalImageName:@"filmfatoryplayer_share" selecteImageName:@"filmfatoryplayer_share" target:self selector:@selector(shareAction:)];
    [headerView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(downloadBtn.mas_left).offset(-11.0f);
        make.centerY.equalTo(copyrighLabel);
        make.size.mas_equalTo(CGSizeMake(29, 29));
    }];
    
    // 收藏
    UIButton *collectBtn = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_player_icon_nomal" selecteImageName:@"pandaMovie_player_seltcd_icon" target:self selector:@selector(collectAction:)];
    [headerView addSubview:collectBtn];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(shareBtn.mas_left).offset(-11.0f);
        make.centerY.equalTo(copyrighLabel);
        make.size.mas_equalTo(CGSizeMake(29, 29));
    }];
    self.collectBtn = collectBtn;
    if (self.videoPlayerDataModel.videoDetailItem.favourite) {
        self.collectBtn.selected = YES;
    }
    
    // 选集
    if (episodes.count) {
        UILabel *titleLabel = [UILabel ly_LabelWithTitle:@"选集" font:zy_blodFontSize17 titleColor:gnh_color_k];
        [headerView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logoImageView.mas_bottom).offset(23.0f);
            make.left.mas_offset(13.0f);
            make.height.mas_offset(16.0f);
        }];
        
        NSString *episodestitle = [NSString stringWithFormat:@"更新至%@集", episodes.lastObject];
        CGSize tagSize = [episodestitle textWithSize:14.0f size:CGSizeZero];
        
        UIButton *episodesBtn = [UIButton ly_ButtonWithTitle:episodestitle titleColor:gnh_color_s font:zy_mediumSystemFont14 target:self selector:@selector(episodesBtnAction:)];
        [episodesBtn setImage:[UIImage imageNamed:@"pandamoview_gray_arrow"] forState:UIControlStateNormal];
        [episodesBtn setImageEdgeInsets:UIEdgeInsetsMake(0, tagSize.width, 0, 0)];
        [episodesBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 10)];
        [headerView addSubview:episodesBtn];
        [episodesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerView).offset(-10.0f);
            make.centerY.equalTo(titleLabel);
            make.width.mas_offset(tagSize.width + 20.0f);
        }];
        
        UIScrollView *containerScrollView = [UIScrollView ly_ViewWithColor:UIColor.whiteColor];
        [headerView addSubview:containerScrollView];
        containerScrollView.showsHorizontalScrollIndicator = NO;
        containerScrollView.showsVerticalScrollIndicator = NO;
        [containerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(15.0f);
            make.left.equalTo(headerView).offset(10.0f);
            make.right.equalTo(headerView).offset(-10.0f);
            make.height.mas_offset(40.0f);
        }];
        
        __block CGFloat origin_x = 0.0f;
        __block CGFloat origin_y = 0.0f;
        __block CGRect tmpRect = CGRectZero;
        __block NSInteger index = 0;
        
        CGSize rectSize = [(NSString *)episodes.firstObject textWithSize:18 size:CGSizeZero];
        [episodes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (tmpRect.size.width > 0) {
                origin_x = CGRectGetMaxX(tmpRect) + 7.5f;
            }
            
            UIButton *tagBtn = [UIButton ly_ButtonWithTitle:obj titleColor:gnh_color_k font:zy_blodFontSize18 target:self selector:@selector(episodesTagAction:)];
            [tagBtn setTitleColor:gnh_color_theme forState:UIControlStateSelected];
            tagBtn.layer.cornerRadius = 5.f;
            tagBtn.layer.borderWidth = 0.5f;
            tagBtn.layer.borderColor = gnh_color_t.CGColor;
            tagBtn.layer.masksToBounds = YES;
            tagBtn.tag = 100 + idx;
            tagBtn.frame = CGRectMake(origin_x, origin_y, rectSize.width + 52.0f, 40.0f);
            [containerScrollView addSubview:tagBtn];
            tmpRect = tagBtn.frame;
            tagBtn.selected = NO;
            if ([weakSelf.videoPlayerDataModel.videoDetailItem.episode isEqualToString:obj]) {
                tagBtn.layer.borderColor = gnh_color_theme.CGColor;
                tagBtn.selected = YES;
                weakSelf.preTagButton = tagBtn;
                
                index = idx;
            }
        }];
        [containerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat kWidth = CGRectGetMaxX(tmpRect);
            if (kWidth + 10 >= kScreenWidth) {
                kWidth = kScreenWidth - 10.0f;
            }
            make.width.mas_offset(kWidth);
        }];
        containerScrollView.contentSize = CGSizeMake(CGRectGetMaxX(tmpRect) + 10, 40.0f);
        self.containerScrollView = containerScrollView;
        
        // 滚动到具体某一集
        UIButton *selectBtn = [self.containerScrollView viewWithTag:(index - 1) + 100];
        if (![self isRectVisibleInScrollView:selectBtn.frame]) {
            [self.containerScrollView scrollRectToVisible:selectBtn.frame animated:YES];
        }
    }
    
    // 添加banner广告
    self.bannerAdView = [[BUNativeExpressBannerView alloc] initWithSlotID:@"946261349" rootViewController:self adSize:CGSizeMake(kScreenWidth - 15, 150) interval:30];
    self.bannerAdView.delegate = self;
    [headerView addSubview:self.bannerAdView];
    [self.bannerAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headerView);
        make.left.right.equalTo(headerView).inset(15.0f);
        make.height.mas_equalTo(150.f);
    }];
    [self.bannerAdView loadAdData];
    
    self.tableView.tableHeaderView = headerView;
}

- (BOOL)isRectVisibleInScrollView:(CGRect)rect
{
    CGRect container = CGRectMake(self.containerScrollView.contentOffset.x, self.containerScrollView.contentOffset.y, kScreenWidth - 20.0f, 40.0f);
    return CGRectIntersectsRect(rect, container);
}

- (void)storeWatchRecord
{
    // 登录后，服务器上报
    if (ORShareAccountComponent.accesstoken.length) {
        NSInteger watchSeconds = 0;
        if (!self.videoPlayerDataModel.videoDetailItem.source.redirectType) {
            watchSeconds = self.player.currentTime;
        }
        [[FilmFacotryVideoReportManager sharedInstance] videoReportWithData:self.videotype videoId:self.videoId watchSeconds:self.player.currentTime];
    }
    
    // 本地存储
    self.videoModel.videoName = self.videoPlayerDataModel.videoDetailItem.videoName;
    self.videoModel.coverImg = self.coverUrl;
    self.videoModel.videoUrl = self.videoPlayerDataModel.videoDetailItem.source.videoUrl;
    self.videoModel.idStr = self.videoId;
    self.videoModel.type = self.videotype;
    self.videoModel.episode = self.currentEpisode;
    
    if (self.videoPlayerDataModel.videoDetailItem.source.redirectType) {
        self.videoModel.watchSeconds = 0.0;
    } else {
        self.videoModel.watchSeconds = self.player.currentTime;
    }
    [[FilmFacotryVideoReportManager sharedInstance] restoreVideoHistory:self.videoModel];
}

#pragma mark - buttonAction

- (void)backClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)throwScreen:(UIButton *)btn
{
    // 记录观看记录，存储前一次观看记录
    [self storeWatchRecord];
    
    // 投屏
    PandaMovieThrowScreenViewController *throwScreenController = [[PandaMovieThrowScreenViewController alloc] init];
    throwScreenController.videoUrl = self.videoPlayerDataModel.videoDetailItem.source.videoUrl;
    [self.navigationController pushViewController:throwScreenController animated:YES];
    
    [self deallocChooseView];
}

- (void)playerAction:(UIButton *)btn
{
    if (self.videoPlayerDataModel.videoDetailItem.source.redirectType) {
        // 跳转第三方
        [self.view bringSubviewToFront:self.playerBackImageView];
        [self.view bringSubviewToFront:self.playButton];
        
        UIViewController *vc = [[PandaMovieH5ViewController alloc] initWithURL:self.videoPlayerDataModel.videoDetailItem.source.redirectLink.urlWithString];
        vc.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        if (self.player.isPlaying) {
            [self.player pause];

            self.playButton.selected = YES;
        } else {
            [self.player play];
            
            self.playButton.selected = NO;
        }
    }
    
    [self deallocChooseView];
}

// 简介
- (void)introBtnAction:(UIButton *)btn
{
    LYCoverView *videoIntroView = [PandaMovieVideoIntroView showIntroAlertView:self.videoPlayerDataModel.videoDetailItem completeBlock:^{
        // code
    }];
    videoIntroView.touchDisMiss = YES;
    
    [self deallocChooseView];
}

// 下载
- (void)downloadAction:(UIButton *)btn
{
    
}

// 分享
- (void)shareAction:(UIButton *)btn
{
    if (![FilmFactoryAccountComponent checkLogin:YES]) {
        return;
    }
    
    // 分享，弹出分享框
    NSString *contentUrl = [@"https://m.iorange99.com/#/pages/index/video?" stringByAppendingFormat:@"id=%@&type=%@", self.videoId, self.videotype];
    [[ORShareTool sharedInstance] shareWithData:self.videoPlayerDataModel.videoDetailItem.videoName
                                       imageUrl:self.videoPlayerDataModel.videoDetailItem.coverImg
                                    description:self.videoPlayerDataModel.videoDetailItem.videoDesc
                                     contentUrl:contentUrl
                                      miniappId:@""
                                    miniappPath:@""
                                     useMiniapp:NO
                                    resultBlock:^(ShareResultType result) {
        if (result == ShareResultTypeSuccess) {
            [SVProgressHUD showInfoWithStatus:@"分享成功"];
            
            // 分享上报
            [self.shareReportDataModel shareReportWithType:self.videoId type:self.videotype];
        } else {
            [SVProgressHUD showInfoWithStatus:@"分享失败"];
        }
    }];
    
    [self deallocChooseView];
}

// 收藏
- (void)collectAction:(UIButton *)btn
{
    if (btn.isSelected) {
        // 已收藏
        if (!self.videoId.length) {
            return;
        }
        
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        paramDic[@"id"] = self.videoId;
        paramDic[@"type"] = self.videotype;
        [self.deleteFavoriteDataModel PandaMoviedeleteFavoriteWithData:[@[paramDic] mutableCopy]];
    } else {
        // 未收藏
        [self.addFavoriteDataModel addfavoriteWithType:self.videoId type:self.videotype];
    }
    
    [self deallocChooseView];
}

// 更新至28集
- (void)episodesBtnAction:(UIButton *)btn
{
    GNHWeakSelf;
    LYCoverView *videoEpisodesView = [PandaMovieVideoEpisodesView showIntroAlertView:self.videoPlayerDataModel.videoDetailItem completeBlock:^(NSInteger index) {
        // 播放第几集
        UIButton *selectBtn = [weakSelf.containerScrollView viewWithTag:index + 100];
        [weakSelf.containerScrollView scrollRectToVisible:selectBtn.frame animated:YES];

        [weakSelf episodesTagAction:selectBtn];
    }];
    videoEpisodesView.touchDisMiss = YES;
    
    [self deallocChooseView];
}

// 点击第几集
- (void)episodesTagAction:(UIButton *)btn
{
    self.preTagButton.selected = NO;
    self.preTagButton.layer.borderColor = gnh_color_t.CGColor;
    self.preTagButton = btn;
    self.preTagButton.selected = YES;
    self.preTagButton.layer.borderColor = gnh_color_theme.CGColor;
    
    NSString *sourceName = self.videoPlayerDataModel.videoDetailItem.source.sourceName;
    NSArray *episodes = self.videoPlayerDataModel.videoDetailItem.episodes[sourceName];
    NSString *episode = [episodes mdf_safeObjectAtIndex:btn.tag - 100];
    if (![episode isEqualToString:self.currentEpisode] && [episode isKindOfClass:[NSString class]]) {
        self.currentEpisode = episode;
        self.watchSeconds = 0;
        // 请求播放地址
        [self.videoPlayerDataModel fetchVideoDetialWithParams:self.videoId videoType:self.videotype sourceName:sourceName episode:self.currentEpisode];
        [self setUpTableSqualData];
    }
    
    [self deallocChooseView];
}

- (void)chooseSource
{
    if (self.chooseSourceView) {
        [self deallocChooseView];
    } else {
        GNHWeakSelf;
        PandaMovieChooseSourceView *chooseSourceView = [[PandaMovieChooseSourceView alloc] PandaMovieinitWithFrame:CGRectZero sources:self.videoPlayerDataModel.videoDetailItem.sourceList selectSource:self.currentSourceName];
        chooseSourceView.layer.cornerRadius = 8.0f;
        [self.tableView addSubview:chooseSourceView];
        [self.tableView bringSubviewToFront:chooseSourceView];
        [chooseSourceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(115.0f + 10.0f);
            make.left.mas_offset(10.0f);
            
            if (self.videoPlayerDataModel.videoDetailItem.sourceList.count % 3 == 0) {
                make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20.0f, (36.0f + 10) * (self.videoPlayerDataModel.videoDetailItem.sourceList.count / 3)));
            } else {
                make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20.0f, (36.0f + 10) * (self.videoPlayerDataModel.videoDetailItem.sourceList.count / 3 + 1)));
            }
        }];
        self.chooseSourceView = chooseSourceView;
        self.chooseSourceView.chooseSourceCompleteBlock = ^(NSString * _Nonnull sourceName) {
            // 视频详情
            [weakSelf.videoPlayerDataModel fetchVideoDetialWithParams:weakSelf.videoId videoType:weakSelf.videotype sourceName:sourceName episode:weakSelf.currentEpisode];
            
            weakSelf.isChooseSource = YES;
        };
        self.dropdownBtn.selected = YES;
    }
}

- (void)deallocChooseView
{
    [self.chooseSourceView removeFromSuperview];
    self.chooseSourceView = nil;
    self.isChooseSource = NO;
    self.dropdownBtn.selected = NO;
}

#pragma mark - Refresh

- (void)refreshData
{
    BOOL flag = [self.videoRecommendDataModel fetchRecommendVideo:self.videoId type:self.videotype]; // 默认一次性请求个
    if (flag) {
        self.videoRecommendDataModel.loadType = GNHDataModelLoadTypeRefresh;
    } else {
        [self stopPullDownToRefreshAnimation];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self deallocChooseView];
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMovieVideoPlayerDataModel class]]) {
        [self configData];
        
        // 刷新推荐数据
        if (!self.isChooseSource) {
            [self refreshData];
        }
    } else if ([gnhModel isMemberOfClass:[PandaMovieVideoRecommendDataModel class]]) {
        [self stopPullDownToRefreshAnimation];

        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;
        
        PandaMovieVideoRecommendItem *recommendItem = [[PandaMovieVideoRecommendItem alloc] init];
        recommendItem.data = [self.videoRecommendDataModel.videoRecommendItem.data mutableCopy];
        sectionObject.items = [@[recommendItem] mutableCopy];
        
        [self.tableView reloadData];
    } else if ([gnhModel isMemberOfClass:[PandaMoviewAddFavoriteDataModel class]]) {
        self.collectBtn.selected = YES;
    } else if ([gnhModel isMemberOfClass:[PandaMovieDeleteFavoriteDataModel class]]) {
        self.collectBtn.selected = NO;
    } else if ([gnhModel isMemberOfClass:[ORShareReportDataModel class]]) {
        // 分享上报成功
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMovieVideoRecommendDataModel class]]) {
        [self stopPullDownToRefreshAnimation];
    }
}

#pragma mark - Properties

- (PandaMovieVideoPlayerDataModel *)videoPlayerDataModel
{
    if (!_videoPlayerDataModel) {
        _videoPlayerDataModel = [self produceModel:[PandaMovieVideoPlayerDataModel class]];
    }
    return _videoPlayerDataModel;
}

- (PandaMovieVideoRecommendDataModel *)videoRecommendDataModel
{
    if (!_videoRecommendDataModel) {
        _videoRecommendDataModel = [self produceModel:[PandaMovieVideoRecommendDataModel class]];
    }
    return _videoRecommendDataModel;
}

- (PandaMoviewAddFavoriteDataModel *)addFavoriteDataModel
{
    if (!_addFavoriteDataModel) {
        _addFavoriteDataModel = [self produceModel:[PandaMoviewAddFavoriteDataModel class]];
    }
    return _addFavoriteDataModel;
}

- (PandaMovieDeleteFavoriteDataModel *)deleteFavoriteDataModel
{
    if (!_deleteFavoriteDataModel) {
        _deleteFavoriteDataModel = [self produceModel:[PandaMovieDeleteFavoriteDataModel class]];
    }
    return _deleteFavoriteDataModel;
}

- (ORShareReportDataModel *)shareReportDataModel
{
    if (!_shareReportDataModel) {
        _shareReportDataModel = [self produceModel:[ORShareReportDataModel class]];
    }
    return _shareReportDataModel;
}
#pragma mark--穿山甲 BUNativeExpressFullscreenVideoAdDelegate
- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
//回调后再去展示广告，可保证播放和展示效果
    if (self.fullscreenAd) {

          UIWindow * window = [AppDelegate shareDelegate].window;
         window.backgroundColor = [UIColor clearColor];
        [self.fullscreenAd showAdFromRootViewController:window.rootViewController];
    }
}
- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
//在此回调方法中可进行广告的置空操作
    self.fullscreenAd = nil;
}
@end
