
#import "PandaMovieHotVideoView.h"
#import "PandaMovieDoubleLikeView.h"
#import <SJVideoPlayer/SJVideoPlayer.h>
#import <SJBaseVideoPlayer/UIScrollView+ListViewAutoplaySJAdd.h>
#import <SJUIKit/UIScrollView+SJRefreshAdd.h>
#import <SJMediaCacheServer/SJMediaCacheServer.h>
#import "PandaMovieDYTableViewCell.h"
#import <MJRefresh.h>

#define ORDataSize  20

@interface PandaMovieHotVideoView()<PandaMovieHotVideoControlViewDelegate, UITableViewDataSource, UITableViewDelegate, SJPlayerAutoplayDelegate>

@property (nonatomic, strong) SJVideoPlayer *player;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieHotChannelDataItem *> *videos;

@property (nonatomic, strong, nullable) id<MCSPrefetchTask> prePrefetchTask;
@property (nonatomic, strong, nullable) id<MCSPrefetchTask> nextPrefetchTask;

@property (nonatomic, assign) BOOL                      isRefreshMore;

@property (nonatomic, strong) PandaMovieDoubleLikeView          *doubleLikeView;

// 控制播放的索引，不完全等于当前播放内容的索引
@property (nonatomic, assign) NSInteger                 index;

@property (nonatomic, assign) NSInteger dataPage;

@end

@implementation PandaMovieHotVideoView

#pragma mark - LifeCycle

- (void)vc_viewDidAppear
{
    [self.player vc_viewDidAppear];
}

- (void)vc_viewWillDisappear
{
    [self.player vc_viewWillDisappear];
}

- (void)vc_viewDidDisappear
{
    [self.player vc_viewDidDisappear];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataPage = 1;
        
        [self setupTableView];
        
        [self setupVideoPlayer];
        
        [self setupMediaCacheServer];
    }
    return self;
}

- (void)setupVideoPlayer
{
    // 初始化播放器
    SJVideoPlayer.updateResources(^(id<SJVideoPlayerControlLayerResources>  _Nonnull resources) {
        resources.placeholder = [UIImage imageNamed:@"placeholder"];
        resources.progressThumbSize = 8;
        resources.progressTrackColor = [UIColor colorWithWhite:0.3 alpha:1];
        resources.progressBufferColor = [UIColor colorWithWhite:0.6 alpha:1];
        resources.progressTraceColor = UIColor.whiteColor;
        resources.progressThumbColor = UIColor.whiteColor;
        resources.bottomIndicatorTraceColor = UIColor.whiteColor;
        resources.bottomIndicatorTrackColor = [UIColor colorWithWhite:0.3 alpha:1];
        resources.fullscreenImage = [UIImage imageNamed:@"pandaMoview_FullScreen_icon"];
        resources.backImage = [UIImage imageNamed:@"pandaMoview_leff_white_arrow"];
    });
    
    SJVideoPlayer *player = [SJVideoPlayer player];
    player.view.backgroundColor = UIColor.clearColor;
    player.presentView.backgroundColor = UIColor.clearColor;
    player.videoGravity = AVLayerVideoGravityResizeAspect;
    player.autoplayWhenSetNewAsset = NO;
//    player.autoManageViewToFitOnScreenOrRotation = NO;
    [player setAutomaticallyPerformRotationOrFitOnScreen:NO];
    
//    player.useFitOnScreenAndDisableRotation = YES;
//    [player setFitOnScreenManager:self];
    [player setFitOnScreen:NO];
    player.pauseWhenAppDidEnterBackground = NO;
    player.resumePlaybackWhenScrollAppeared = NO;
    player.resumePlaybackWhenAppDidEnterForeground = YES;
    player.defaultEdgeControlLayer.hiddenBottomProgressIndicator = YES;
    player.controlLayerAppearManager.interval = 5; // 设置控制层隐藏间隔
    
    [self addSubview:player.view];
    [player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.player = player;

    // 删除不需要的item
    [self removeExtraItems];

    GNHWeakObj(_player);
    GNHWeakSelf;
    
    // 播放完毕后, 重新播放. 也就是循环播放
    self.player.playbackObserver.playbackDidFinishExeBlock = ^(__kindof SJBaseVideoPlayer * _Nonnull player) {
        [weak_player replay];
    };
//    self.player.defaultEdgeControlLayer.bottomMargin = 60.0f;
    self.player.defaultEdgeControlLayer.topContainerView.backgroundColor = UIColor.clearColor;
    self.player.defaultEdgeControlLayer.bottomContainerView.backgroundColor = UIColor.clearColor;
    self.player.defaultEdgeControlLayer.draggingProgressPopupView.hidden = YES;

    __weak typeof(self) _self = self;
    // 播放资源状态改变
    self.player.playbackObserver.assetStatusDidChangeExeBlock = ^(__kindof SJBaseVideoPlayer * _Nonnull player) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        PandaMovieDYTableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:self.tableView.sj_currentPlayingIndexPath];

        if (player.assetStatus == SJAssetStatusPreparing) {
            [currentCell startLoading];
        } else if (player.assetStatus == SJAssetStatusReadyToPlay) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [currentCell stopLoading];
            });
        }
    };
    
    // 播放时长改变
    self.player.playbackObserver.currentTimeDidChangeExeBlock = ^(__kindof SJBaseVideoPlayer * _Nonnull player) {
        PandaMovieDYTableViewCell *currentCell = [weakSelf.tableView cellForRowAtIndexPath:weakSelf.tableView.sj_currentPlayingIndexPath];
        if (player.duration > 0) {
            CGFloat value = player.currentTime / (player.duration * 1.0);
            [currentCell setProgress:value];
        }
    };
    
    // 点击
    self.player.controlLayerAppearObserver.appearStateDidChangeExeBlock = ^(id<SJControlLayerAppearManager>  _Nonnull mgr) {
        PandaMovieDYTableViewCell *currentCell = [weakSelf.tableView cellForRowAtIndexPath:weakSelf.tableView.sj_currentPlayingIndexPath];
        currentCell.isPlayButtonHidden = !mgr.isAppeared;
    };
}

/// 删除当前不需要的item
- (void)removeExtraItems
{
    [self.player.defaultEdgeControlLayer.bottomAdapter removeItemForTag:SJEdgeControlLayerBottomItem_Play];
    [self.player.defaultEdgeControlLayer.bottomAdapter removeItemForTag:SJEdgeControlLayerBottomItem_Separator];
    [self.player.defaultEdgeControlLayer.bottomAdapter removeItemForTag:SJEdgeControlLayerBottomItem_Full];
    [self.player.defaultEdgeControlLayer.bottomAdapter exchangeItemForTag:SJEdgeControlLayerBottomItem_DurationTime withItemForTag:SJEdgeControlLayerBottomItem_Progress];
    
    SJEdgeControlButtonItem *currentTimeitem = (SJEdgeControlButtonItem *)[self.player.defaultEdgeControlLayer.bottomAdapter itemForTag:SJEdgeControlLayerBottomItem_CurrentTime];
    currentTimeitem.insets = SJEdgeInsetsMake(15, 0);
    SJEdgeControlButtonItem *durationTimeitem = (SJEdgeControlButtonItem *)[self.player.defaultEdgeControlLayer.bottomAdapter itemForTag:SJEdgeControlLayerBottomItem_DurationTime];
    durationTimeitem.insets = SJEdgeInsetsMake(0, 15);

    self.player.defaultEdgeControlLayer.bottomContainerView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    self.player.defaultEdgeControlLayer.topContainerView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    [self.player.defaultEdgeControlLayer.bottomAdapter reload];
}

- (void)setupTableView
{
    
    UITableView *tableView = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.blackColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.pagingEnabled = YES;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.tableView = tableView;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    // 注册cell
    [PandaMovieDYTableViewCell registerWithTableView:tableView];
    
    // 开启滑动自动播放
    SJPlayerAutoplayConfig *config = [SJPlayerAutoplayConfig configWithAutoplayDelegate:self];
    config.autoplayPosition = SJAutoplayPositionMiddle; // 播放距离中线最近的视频
    [self.tableView sj_enableAutoplayWithConfig:config];
}

// 配置边播边缓存模块
- (void)setupMediaCacheServer
{
    // 开启控制台log
    SJMediaCacheServer.shared.enabledConsoleLog = YES;
    SJMediaCacheServer.shared.resolveAssetIdentifier = ^NSString * _Nonnull(NSURL * _Nonnull URL) {
        return [URL.absoluteString stringByDeletingPathExtension];
    };
}

#pragma mark - setupData

// 预加载指定位置的某个资源`10M`的内容
- (nullable id<MCSPrefetchTask>)_prefetchTaskWithIndex:(NSInteger)index
{
    if ( index < 0 || index >= _videos.count )
        return nil;
    return [SJMediaCacheServer.shared prefetchWithURL:_videos[index].videoUrl.urlWithString preloadSize:10 * 1024 * 1024];
}

- (void)setModels:(NSArray *)models index:(NSInteger)index
{
    [self setModels:models index:index canRefresh:YES];
}

- (void)setModels:(NSArray *)models index:(NSInteger)index canRefresh:(BOOL)canRefresh
{
    if (models.count == 0) return;

    [self.videos removeAllObjects];
    [self.videos addObjectsFromArray:models];
    self.index = index;
    [self.tableView reloadData];
    
    if (canRefresh) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView sj_playAssetAtIndexPath:indexPath scrollAnimated:NO];
        
        // 请求列表数据
        GNHWeakSelf;
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf refreshMore];
        }];
        [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
        self.tableView.mj_footer = footer;

        // 加载推荐
        [footer executeRefreshingCallback];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.tableView sj_playAssetAtIndexPath:indexPath scrollAnimated:NO];
        });
    }
}

#pragma mark - UITableView delete & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PandaMovieDYTableViewCell *cell = [PandaMovieDYTableViewCell cellWithTableView:tableView indexPath:indexPath];
    cell.videoItem = self.videos[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PandaMovieDYTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [_tableView.sj_currentPlayingIndexPath isEqual:indexPath] ) {
        [_player stop];
        [_tableView sj_removeCurrentPlayerView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight;
}

#pragma mark - SJPlayerAutoplayDelegate

- (void)sj_playerNeedPlayNewAssetAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath == nil )
        return;
    
    // 进行播放
    NSURL *URL = _videos[indexPath.row].videoUrl.urlWithString;
    NSURL *playbackURL = [SJMediaCacheServer.shared playbackURLWithURL:URL];
    _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:playbackURL playModel:[SJPlayModel playModelWithTableView:_tableView indexPath:indexPath]];
    [_player play];
    
    // 进行预加载
    [_prePrefetchTask cancel];
    [_nextPrefetchTask cancel];
    _prePrefetchTask = [self _prefetchTaskWithIndex:indexPath.row - 1]; // 预加载前一个视频
    _nextPrefetchTask = [self _prefetchTaskWithIndex:indexPath.row + 1]; // 预加载后一个视频
    
    // 请求详情，是否点赞和收藏
    if (self.updateVideoDetailCompleteBlock) {
        self.updateVideoDetailCompleteBlock(self.videos[indexPath.row].idStr);
    }
    
    if (indexPath.row == self.videos.count - 1) {
        // 自动加载下一页
        [self.tableView.mj_footer executeRefreshingCallback];
    }
    
    // 隐藏播放按钮 和 播放器底部控制层
    PandaMovieDYTableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:indexPath];
    [currentCell resumePlayStatus:NO];
    currentCell.isPlayButtonHidden = YES;
    [self.player controlLayerNeedDisappear];
}

#pragma mark - action

// 获取当前播放内容的索引
- (NSInteger)indexOfModel:(PandaMovieHotChannelDataItem *)model
{
    __block NSInteger index = 0;
    [self.videos enumerateObjectsUsingBlock:^(PandaMovieHotChannelDataItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.idStr isEqualToString:obj.idStr]) {
            index = idx;
        }
    }];
    return index;
}

- (void)refreshUI:(PandaMovieHotVideoDetailItem *)videoDetailItem
{
    __block NSInteger index = 0;
    [self.videos enumerateObjectsUsingBlock:^(PandaMovieHotChannelDataItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([videoDetailItem.idStr isEqualToString:obj.idStr]) {
            index = idx;
            obj.like = videoDetailItem.like;
            obj.favourite = videoDetailItem.favourite;
            *stop = YES;
        }
    }];

    PandaMovieDYTableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:self.tableView.sj_currentPlayingIndexPath];
    currentCell.videoItem = self.videos[index];
}

- (void)favorite:(NSString *)videoId actionType:(NSInteger)action
{
    __block NSInteger index = 0;
    [self.videos enumerateObjectsUsingBlock:^(PandaMovieHotChannelDataItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([videoId isEqualToString:obj.idStr]) {
            index = idx;
            obj.favourite = action;
            *stop = YES;
        }
    }];

    PandaMovieDYTableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:self.tableView.sj_currentPlayingIndexPath];
    currentCell.videoItem = self.videos[index];
}

- (void)praise:(NSString *)videoId actionType:(NSInteger)action
{
    __block NSInteger index = 0;
    [self.videos enumerateObjectsUsingBlock:^(PandaMovieHotChannelDataItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([videoId isEqualToString:obj.idStr]) {
            index = idx;
            obj.like = action;
            if (action == 1) {
                obj.likes ++;
            } else {
                obj.likes --;
            }
            *stop = YES;
        }
    }];

    PandaMovieDYTableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:self.tableView.sj_currentPlayingIndexPath];
    currentCell.videoItem = self.videos[index];
}

- (void)refreshMore
{
    if (self.isRefreshMore) return;
    self.isRefreshMore = YES;
    
    // 获取数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"limit"] = @"20";
    params[@"page"] = @(self.dataPage);
    
    NSString *address = [NSString gnh_addressWithString:ORHotChannelAddress];
    address = [address stringByAppendingFormat:@"/%@", self.videotype];
    [[ORNetworkingManager sharedInstance] requestBaseUrl:[NSString gnh_httpServerHost:GNHBaseURLTypeClient]
                                             withAddress:address
                                                  params:params
                                              requesType:ORRequestTypeGet
                                           completeBlock:^(id responseObject, BOOL isSuccess) {
        if (isSuccess) {
            self.isRefreshMore = NO;

            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *videoList = dic[@"data"][@"list"];
            NSMutableArray *array = [NSMutableArray new];
            
            if ([videoList isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in videoList) {
                    PandaMovieHotChannelDataItem *model = [PandaMovieHotChannelDataItem yy_modelWithDictionary:dict];
                    
                    if ([dict[@"id"] isKindOfClass:[NSNumber class]]) {
                        model.idStr = [dict[@"id"] stringValue];
                    } else {
                        model.idStr = dict[@"id"];
                    }
                    [array addObject:model];
                }

                if (array.count) {
                    [self.videos addObjectsFromArray:array];
                    [self.tableView.mj_footer endRefreshing];

                    // 添加到播放列表中, 刷新列表
                    [self.tableView reloadData];
                    [self.tableView sj_playNextVisibleAsset];
                    
                    self.dataPage ++;
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
                if (videoList.count <= 20.0f) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
        } else {
            self.isRefreshMore = NO;
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - ORHotVideoControlViewDelegate

- (void)controlView:(PandaMovieDYTableViewCell *)controlView touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 暂时隐藏双击点赞动画
//    [self.doubleLikeView createAnimationWithTouch:touches withEvent:event];
//    [controlView showLikeAnimation];

    if ([self.delegate respondsToSelector:@selector(videoView:didClickPraise:)]) {
        [self.delegate videoView:self didClickPraise:controlView.videoItem];
    }
}

- (void)controlViewDidClickPriase:(PandaMovieDYTableViewCell *)controlView
{
    if ([self.delegate respondsToSelector:@selector(videoView:didClickPraise:)]) {
        [self.delegate videoView:self didClickPraise:controlView.videoItem];
    }
}

- (void)controlViewDidClickCollect:(PandaMovieDYTableViewCell *)controlView
{
    if ([self.delegate respondsToSelector:@selector(videoView:didClickCollect:)]) {
        [self.delegate videoView:self didClickCollect:controlView.videoItem];
    }
}

- (void)controlViewDidClickShare:(PandaMovieDYTableViewCell *)controlView
{
    if ([self.delegate respondsToSelector:@selector(videoView:didClickShare:)]) {
        [self.delegate videoView:self didClickShare:controlView.videoItem];
    }
}

- (void)controlViewDidClickPlayBtn:(PandaMovieDYTableViewCell *)controlView
{
    // 播放按钮点击
    if (controlView.isPlayButtonSelected) {
        [self.player pauseForUser];
    } else {
        [self.player play];
    }
}

#pragma mark - 懒加载

- (NSMutableArray<__kindof PandaMovieHotChannelDataItem *> *)videos
{
    if (!_videos) {
        _videos = [NSMutableArray new];
    }
    return _videos;
}

- (PandaMovieDoubleLikeView *)doubleLikeView
{
    if (!_doubleLikeView) {
        _doubleLikeView = [PandaMovieDoubleLikeView new];
    }
    return _doubleLikeView;
}

@end
