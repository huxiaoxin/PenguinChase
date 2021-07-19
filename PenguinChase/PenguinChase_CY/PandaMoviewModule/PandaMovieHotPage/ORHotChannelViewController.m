//
//  ORHotChannelViewController.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/19.
//

#import "ORHotChannelViewController.h"
#import "PandaMovieHotChannelDataModel.h"
#import "ORHotChannelTableViewCell.h"
#import "PandaMovieChannelNoDataView.h"
#import "PandaMovieHotDetailViewController.h"
#define kchannelDataSize  20 // 默认请求20条数据

@interface ORHotChannelViewController ()
@property (nonatomic, strong) PandaMovieHotChannelDataModel *hotChannelDataModel; // 数据

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger dataPage; // 数据页码
@property (nonatomic, assign) NSInteger preDataPage;

@property (nonatomic, strong) PandaMovieChannelNoDataView *noDataView;

@end

@implementation ORHotChannelViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupDatas];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - SetupData

- (void)setupUI
{
    CGRect rect = self.tableView.frame;
    rect.size.height = self.view.size.height;
    rect.origin.x = 0.0f;
    rect.origin.y = 0.0f;
    self.tableView.frame = rect;
    
    self.isNeedPullDownToRefreshAction = YES;
    self.isNeedPullUpToRefreshAction = YES;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = LGDViewBJColor;
    
    // 配置数据
    GNHTableViewSectionObject *hotspotSectionObject = [[GNHTableViewSectionObject alloc] init];
    self.sections = [@[hotspotSectionObject] mutableCopy];
    [self.tableView reloadData];
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isKindOfClass:[PandaMovieHotChannelDataItem class]]) {
        return [ORHotChannelTableViewCell class];
    }
    
    return nil;
}

- (void)configForCell:(GNHBaseTableViewCell *)cell item:(id)item
{
    if ([item isKindOfClass:[PandaMovieHotChannelDataItem class]]) {
        GNHWeakSelf;
        ORHotChannelTableViewCell *channelTableViewCell = (ORHotChannelTableViewCell *)cell;
        channelTableViewCell.hotChannelActionBlock = ^(PandaMovieHotChannelDataItem * _Nonnull dataItem, ORHotChannelActionType type) {
            switch (type) {
                case ORHotChannelActionTypeMore: {
                    // 更多
                    [weakSelf gnh_showSheetWithTitle:nil message:nil appearanceProcess:^(GNHAlertController *alertMaker) {
                        alertMaker.addActionDefaultTitle(@"看过了");
                        alertMaker.addActionDefaultTitle(@"不感兴趣");
                        alertMaker.addActionCancelTitle(@"取消");
                    } actionsBlock:^(NSInteger index, UIAlertAction *action, GNHAlertController *alertMaker) {
                        // 屏蔽3天
                        NSDictionary *idDic = [ORUserDefaults objectForKey:ORForbidContentKey];
                        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:idDic];
                        [tempDic mdf_safeSetObject:[NSDate date] forKey:dataItem.idStr];
                        [ORUserDefaults setObject:tempDic forKey:ORForbidContentKey];
                        [ORUserDefaults synchronize];

                        // 删除当前数据
                        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;
                        NSMutableArray *tmpArr = [sectionObject.items mutableCopy];
                        [tmpArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            PandaMovieHotChannelDataItem *cellItem = (PandaMovieHotChannelDataItem *)obj;
                            if ([dataItem.idStr isEqualToString:cellItem.idStr]) {
                                [sectionObject.items mdf_safeRemoveObject:obj];
                            }
                        }];
                        [weakSelf.tableView reloadData];
                    }];
                    break;
                }
                case ORHotChannelActionTypeShare: {
                    // 分享
                }
                case ORHotChannelActionTypeLike: {
                    // 点赞
                }
                default: {
                    [FilmFactoryUMConfig analytics:pandazj_hotVideo_play label:@"短视频播放"];
                    // 播放
                    PandaMovieHotDetailViewController *hotDetailVC = [[PandaMovieHotDetailViewController alloc] initWithVideos:@[dataItem] index:0];
                    hotDetailVC.hidesBottomBarWhenPushed = YES;
                    hotDetailVC.videoView.videotype = self.typeId;
                    [weakSelf.navigationController pushViewController:hotDetailVC animated:YES];
                    break;
                }
            }
        };
    }
}

#pragma mark - setupData

- (void)setupDatas
{
    self.dataPage = 1;
}

- (void)setTypeId:(NSString *)typeId
{
    _typeId = typeId;

    // 刷新
    [self pullDownToRefreshAction];
}


#pragma mark - VTMagicReuseProtocol delegate

- (void)vtm_prepareForReuse
{
    // 清空数据
    GNHTableViewSectionObject *section =  self.sections.firstObject;
    [section.items removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - Refresh

- (void)pullDownToRefreshAction
{
    [super pullDownToRefreshAction];
        
    self.dataPage = 1;
    
    // 请求今日热播，首页默认最多6条
    BOOL flag = [self.hotChannelDataModel fetchHotChannelWithPage:self.dataPage limit:kchannelDataSize type:self.typeId];
    if (flag) {
        self.hotChannelDataModel.loadType = GNHDataModelLoadTypeRefresh;
    } else {
        self.dataPage = self.preDataPage;
        [self stopPullDownToRefreshAnimation];
    }
}

- (void)pullUpToRefreshAction
{
    [super pullUpToRefreshAction];
    
    self.preDataPage = self.dataPage;

    self.dataPage += 1;
    BOOL flag = [self.hotChannelDataModel fetchHotChannelWithPage:self.dataPage limit:kchannelDataSize type: self.typeId];
    if (flag) {
        self.hotChannelDataModel.loadType = GNHDataModelLoadTypeLoadMore;
    } else {
        self.dataPage = self.preDataPage;
        [self stopPullUpToRefreshAnimation];
    }
}

- (NSMutableArray *)filterData:(NSMutableArray <__kindof PandaMovieHotChannelDataItem *> *)list
{
    NSMutableArray <__kindof PandaMovieHotChannelDataItem *> *tmpArr = [list mutableCopy];
    
    // 清除超过3天的数据
    NSMutableDictionary *idDic = [ORUserDefaults objectForKey:ORForbidContentKey];
    NSArray *keys = idDic.allKeys;
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *idStr = (NSString *)obj;
        [list enumerateObjectsUsingBlock:^(__kindof PandaMovieHotChannelDataItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([idStr isEqualToString:obj.idStr]) {
                [tmpArr mdf_safeRemoveObject:obj];
                *stop = YES;
            }
        }];
    }];
    
    return tmpArr;
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    
    if ([gnhModel isMemberOfClass:[PandaMovieHotChannelDataModel class]]) {
        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;
        if (gnhModel.loadType == GNHDataModelLoadTypeRefresh) {
            // 下拉刷新，数据还原
            [self stopPullDownToRefreshAnimation];
            sectionObject.items = [self filterData:self.hotChannelDataModel.hotChannelItem.list];
        } else {
            // 上拉加载
            NSMutableArray *channelItems = [sectionObject.items mutableCopy];
            [channelItems mdf_safeAddObjectsFromArray:[self filterData:self.hotChannelDataModel.hotChannelItem.list]];
            sectionObject.items = [channelItems mutableCopy];
            
            if (self.hotChannelDataModel.hotChannelItem.list.count < self.hotChannelDataModel.hotChannelItem.pageSize) {
                [self reloadDataWithHasMore:NO];
                
                if (!self.hotChannelDataModel.hotChannelItem.list.count) {
                    // 没有数据，刷新页数不变
                    self.dataPage = self.preDataPage;
                }
            } else {
                [self reloadDataWithHasMore:YES];
            }
        }
        
        // 没有数据
        NSMutableArray *channelItems = [sectionObject.items mutableCopy];
        if (!channelItems.count) {
            self.noDataView.hidden = NO;
        } else {
            self.noDataView.hidden = YES;
        }
        
        [self.tableView reloadData];
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMovieHotChannelDataModel class]]) {
        [self stopPullDownToRefreshAnimation];
        
        if (gnhModel.loadType == GNHDataModelLoadTypeLoadMore) {
            self.dataPage = self.preDataPage;
            [self stopPullUpToRefreshAnimation];
        }        
    }
}

#pragma mark - Properties

- (PandaMovieHotChannelDataModel *)hotChannelDataModel
{
    if (!_hotChannelDataModel) {
        _hotChannelDataModel = [self produceModel:[PandaMovieHotChannelDataModel class]];
    }
    return _hotChannelDataModel;
}

- (PandaMovieChannelNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[PandaMovieChannelNoDataView alloc] init];
        [self.tableView addSubview:_noDataView];
        [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.tableView);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, self.view.height));
        }];
    }
    return _noDataView;
}

@end
