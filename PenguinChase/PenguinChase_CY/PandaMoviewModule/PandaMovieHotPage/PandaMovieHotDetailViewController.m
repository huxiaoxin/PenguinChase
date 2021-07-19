
#import "PandaMovieHotDetailViewController.h"
#import "PandaMovieLikeView.h"
#import "PandaMovieHotVideoDetailDataModel.h"
#import "PandaMoviewAddFavoriteDataModel.h"
#import "PandaMovieDeleteFavoriteDataModel.h"
#import "PandaMovieHotVideoPraiseDataModel.h"
#import "PandaMovieHotVideoRemovePraiseDataModel.h"
#import "FilmFacotryVideoReportManager.h"
#import "ORShareTool.h"
#import "ORShareReportDataModel.h"


#define kTitleViewY     (ORKitMacros.statusBarHeight + 20.0f)
// 过渡中心点
#define kTransitionCenter   20.0f

@interface PandaMovieHotDetailViewController ()<PandaMovieHotVideoViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) PandaMovieHotVideoDetailDataModel *hotVideoDetailDataModel;
@property (nonatomic, strong) PandaMoviewAddFavoriteDataModel *addFavoriteDataModel; // 添加收藏
@property (nonatomic, strong) PandaMovieDeleteFavoriteDataModel *deleteFavoriteDataModel; // 取消收藏
@property (nonatomic, strong) PandaMovieHotVideoPraiseDataModel *hotVideoPraiseDataModel; // 点赞
@property (nonatomic, strong) PandaMovieHotVideoRemovePraiseDataModel *hotVideoRemovePraiseDataModel; // 取消点赞
@property (nonatomic, strong) ORShareReportDataModel *shareReportDataModel; // 分享上报

@property (nonatomic, strong) UIButton              *backBtn;
@property (nonatomic, strong) UIButton              *moreBtn;

@property (nonatomic, strong) NSArray               *videos;
@property (nonatomic, assign) NSInteger             playIndex;
@property (nonatomic, assign) BOOL                  isSingleItem;

@property (nonatomic, copy) NSString *currentVideoId; // 当前视频ID

@property (nonatomic, assign) NSUInteger beginTimeStamp; // 开始时间戳
@property (nonatomic, assign) NSUInteger endTimeStamp; // 开始时间戳

@end

@implementation PandaMovieHotDetailViewController

#pragma mark - LifeCycle

- (instancetype)initWithVideoModel:(PandaMovieHotChannelDataItem *)videoItem
{
    if (self = [super init]) {
        self.videos = [@[videoItem] copy];
        self.playIndex = 0;
        self.isSingleItem = YES;
    }
    return self;
}

- (instancetype)initWithVideos:(NSArray *)videos index:(NSInteger)index
{
    if (self = [super init]) {
        self.videos = videos;
        self.playIndex = index;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.videoView vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.videoView vc_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.videoView vc_viewDidDisappear];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - setupUI

- (void)setupUI
{    
    [self.view addSubview:self.videoView];
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
        
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15.0f);
        make.top.equalTo(self.view).offset(ORKitMacros.statusBarHeight + 20.0f);
        make.width.height.mas_equalTo(44.0f);
    }];
        
//    [self.view addSubview:self.moreBtn];
//    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-15.0f);
//        make.centerY.equalTo(self.backBtn);
//    }];
}

#pragma mark - setupData

- (void)setupData
{
    self.view.backgroundColor = [UIColor blackColor];
    self.fd_prefersNavigationBarHidden = YES;
    
    // 配置数据
    if (self.isSingleItem) {
        [self.videoView setModels:self.videos index:self.playIndex canRefresh:NO];
    } else {
        [self.videoView setModels:self.videos index:self.playIndex];
    }
}

#pragma mark - ButtonAction

- (void)moreClick:(id)sender
{
    
}

- (void)backClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ORHotVideoViewDelegate

// 点赞
- (void)videoView:(PandaMovieHotVideoView *)videoView didClickPraise:(PandaMovieHotChannelDataItem *)videoModel
{
    if (![FilmFactoryAccountComponent checkLogin:YES]) {
        return;
    }
    
    if (videoModel.like) {
        // 已点赞
        [self.hotVideoRemovePraiseDataModel removePraiseWithType:videoModel.idStr type:videoModel.type];
    } else {
        // 未点赞
        [self.hotVideoPraiseDataModel PandaMovieaddPraiseWithType:videoModel.idStr Pandatype:videoModel.type];
    }
    self.currentVideoId = videoModel.idStr;
}

// 分享
- (void)videoView:(PandaMovieHotVideoView *)videoView didClickShare:(PandaMovieHotChannelDataItem *)videoModel
{
    if (![FilmFactoryAccountComponent checkLogin:YES]) {
        return;
    }
    
    // 分享，弹出分享框
    NSString *contentUrl = [@"https://m.iorange99.com/#/pages/hotdot/hotdotDetail?" stringByAppendingFormat:@"id=%@&type=%@", videoModel.idStr, videoModel.type];
    [[ORShareTool sharedInstance] shareWithData:videoModel.videoName
                                       imageUrl:videoModel.coverImg
                                    description:videoModel.videoDesc
                                     contentUrl:contentUrl
                                      miniappId:@""
                                    miniappPath:@""
                                     useMiniapp:NO
                                    resultBlock:^(ShareResultType result) {
        if (result == ShareResultTypeSuccess) {
            [SVProgressHUD showInfoWithStatus:@"分享成功"];
            
            // 分享上报
            [self.shareReportDataModel shareReportWithType:videoModel.idStr type:videoModel.type];
        } else {
            [SVProgressHUD showInfoWithStatus:@"分享失败"];
        }
    }];
}

// 收藏
- (void)videoView:(PandaMovieHotVideoView *)videoView didClickCollect:(PandaMovieHotChannelDataItem *)videoModel
{
    if (![FilmFactoryAccountComponent checkLogin:YES]) {
        return;
    }
    
    if (videoModel.favourite) {
        // 已收藏
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        paramDic[@"id"] = videoModel.idStr;
        paramDic[@"type"] = videoModel.type;
        [self.deleteFavoriteDataModel PandaMoviedeleteFavoriteWithData:[@[paramDic] mutableCopy]];
    } else {
        // 未收藏
        [self.addFavoriteDataModel addfavoriteWithType:videoModel.idStr type:videoModel.type];
    }
    self.currentVideoId = videoModel.idStr;
}

- (void)videoView:(PandaMovieHotVideoView *)videoView didPanWithDistance:(CGFloat)distance isEnd:(BOOL)isEnd
{
    // 手势下来刷新
    if (isEnd) {
        if (distance >= 2 * kTransitionCenter) { // 刷新
            
        } else {
            
        }
    } else {

    }
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMovieHotVideoDetailDataModel class]]) {
        // 更新
        [self.videoView refreshUI:self.hotVideoDetailDataModel.hotVideoDetailItem];
    } else if ([gnhModel isMemberOfClass:[PandaMoviewAddFavoriteDataModel class]]) {
        [self.videoView favorite:self.currentVideoId actionType:1];
    } else if ([gnhModel isMemberOfClass:[PandaMovieDeleteFavoriteDataModel class]]) {
        [self.videoView favorite:self.currentVideoId actionType:0];
    } else if ([gnhModel isMemberOfClass:[PandaMovieHotVideoPraiseDataModel class]]) {
        [self.videoView praise:self.currentVideoId actionType:1];
    } else if ([gnhModel isMemberOfClass:[PandaMovieHotVideoRemovePraiseDataModel class]]) {
        [self.videoView praise:self.currentVideoId actionType:0];
    } else if ([gnhModel isMemberOfClass:[ORShareReportDataModel class]]) {
        // 分享上报成功
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
}

#pragma mark - 懒加载
- (PandaMovieHotVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [[PandaMovieHotVideoView alloc] init];
        _videoView.delegate = self;
        
        GNHWeakSelf;
        _videoView.updateVideoDetailCompleteBlock = ^(NSString * _Nonnull videoId) {
            if (ORShareAccountComponent.accesstoken.length) {
                if ([videoId isKindOfClass:[NSString class]]) {
                    [weakSelf.hotVideoDetailDataModel PandaMoviefetchVideoDetialWithId:videoId];
                }
            }
        };
    }
    return _videoView;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton new];
        [_backBtn setImage:[UIImage imageNamed:@"pandaMoview_leff_white_arrow"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    }
    return _backBtn;
}

- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton new];
        [_moreBtn setImage:[UIImage imageNamed:@"PandaMoview_more_white"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    }
    return _moreBtn;
}

- (PandaMovieHotVideoDetailDataModel *)hotVideoDetailDataModel
{
    if (!_hotVideoDetailDataModel) {
        _hotVideoDetailDataModel = [self produceModel:[PandaMovieHotVideoDetailDataModel class]];
    }
    return _hotVideoDetailDataModel;
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

- (PandaMovieHotVideoPraiseDataModel *)hotVideoPraiseDataModel
{
    if (!_hotVideoPraiseDataModel) {
        _hotVideoPraiseDataModel = [self produceModel:[PandaMovieHotVideoPraiseDataModel class]];
    }
    return _hotVideoPraiseDataModel;
}

- (PandaMovieHotVideoRemovePraiseDataModel *)hotVideoRemovePraiseDataModel
{
    if (!_hotVideoRemovePraiseDataModel) {
        _hotVideoRemovePraiseDataModel = [self produceModel:[PandaMovieHotVideoRemovePraiseDataModel class]];
    }
    return _hotVideoRemovePraiseDataModel;
}

- (ORShareReportDataModel *)shareReportDataModel
{
    if (!_shareReportDataModel) {
        _shareReportDataModel = [self produceModel:[ORShareReportDataModel class]];
    }
    return _shareReportDataModel;
}

@end
