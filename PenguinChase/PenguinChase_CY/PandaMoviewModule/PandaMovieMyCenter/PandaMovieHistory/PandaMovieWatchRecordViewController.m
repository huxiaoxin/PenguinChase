

#import "PandaMovieWatchRecordViewController.h"
#import "PandaMovieWatchRecordTableViewCell.h"
#import "PandaMovieWatchRecordDataModel.h"
#import "PandaMovieDeleteWatchRecordDataModel.h"
#import "PandaMovieChannelNoDataView.h"
#import "FilmFacotryVideoReportManager.h"
#import <BUAdSDK/BUAdSDK.h>
#define kDataSize  20 // 默认请求20条数据

@interface PandaMovieWatchRecordViewController ()<BUNativeExpressBannerViewDelegate>

@property (nonatomic, strong) PandaMovieWatchRecordDataModel *watchRecordDataModel;
@property (nonatomic, strong) PandaMovieDeleteWatchRecordDataModel *deleteWatchRecordDataModel;

@property (nonatomic, assign) NSInteger dataPage; // 数据页码
@property (nonatomic, assign) NSInteger preDataPage;

@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UIButton *deleteBtn;
@property (nonatomic, weak) UIImageView *editView;
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieWatchRecordDataItem *> *dataArr;
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieWatchRecordDataItem *> *deleteArr;
@property (nonatomic, assign) NSInteger deleteNum;

@property (nonatomic, strong) PandaMovieChannelNoDataView *noDataView;

@property (nonatomic, strong) BUNativeExpressBannerView *bannerAdView;  // banner 广告
@property(nonatomic,strong) UIView * tableHeaderView;
@end

@implementation PandaMovieWatchRecordViewController

#pragma mark - LifeCycle
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, 150)];
    }
    return _tableHeaderView;
}
#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupData];
    [self setUpTableSqualData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([FilmFactoryAccountComponent checkLogin:NO]) {
        [self pullDownToRefreshAction];
    } else {
        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;
        sectionObject.items = [[FilmFacotryVideoReportManager sharedInstance].videoItems mutableCopy];
        
        // 没有数据
        [self checkNoDataView];
        
        [self.tableView reloadData];
        
        self.dataArr = [sectionObject.items mutableCopy];
    }
}
#pragma mark - 穿山甲SDK 插屏初始化
-(void)setUpTableSqualData{    
    // 添加banner广告
    self.bannerAdView = [[BUNativeExpressBannerView alloc] initWithSlotID:@"946261349" rootViewController:self adSize:CGSizeMake(kScreenWidth - 15, 150) interval:30];
    self.bannerAdView.tag = 999;
    self.bannerAdView.delegate = self;
    [self.tableHeaderView addSubview:self.bannerAdView];
    [self.bannerAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(15);
        make.height.mas_equalTo(150.f);
    }];
    [self.bannerAdView loadAdData];

    
    
}
#pragma mark - setupUI

- (void)setupUI
{
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 30)];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editButton.titleLabel.font = zy_mediumSystemFont15;
    [editButton setTitle:@"取消" forState:UIControlStateSelected];
    [editButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.editButton = editButton;
    
    // 编辑区域
    UIImageView *editView = [UIImageView ly_ViewWithColor:gnh_color_b];
    [self.view addSubview:editView];
    self.editView = editView;
    editView.userInteractionEnabled = YES;
    [editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(60 + ORKitMacros.iphoneXSafeHeight));
    }];
    self.editView.hidden = YES;
    
    UIView *toplineView = [UIView ly_ViewWithColor:gnh_color_line];
    toplineView.layer.shadowColor = RGBA_HexCOLOR(0x000000, 0.05).CGColor;
    toplineView.layer.shadowOffset = CGSizeMake(0, -1);
    toplineView.layer.shadowOpacity = 1;
    toplineView.layer.shadowRadius = 4;
    [editView addSubview:toplineView];
    [toplineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0.0f);
        make.left.right.equalTo(editView);
        make.height.mas_equalTo(@0.5f);
    }];
        
    UIButton *selectedBtn = [UIButton ly_ButtonWithTitle:@"全选" titleColor:gnh_color_a font:zy_mediumSystemFont15 target:self selector:@selector(selectedBtnClick:)];
    [selectedBtn setTitle:@"取消全选" forState:UIControlStateSelected];
    [editView addSubview:selectedBtn];
    self.selectedBtn = selectedBtn;
    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(editView).offset(-ORKitMacros.iphoneXSafeHeight/2.0);
        make.centerX.equalTo(editView).offset(-(kScreenWidth/4.0));
        make.size.mas_equalTo(CGSizeMake(140, 45));
    }];
    
    UIView *lineView = [UIView ly_ViewWithColor:gnh_color_line];
    [editView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(editView).offset(-ORKitMacros.iphoneXSafeHeight/2.0);
        make.size.mas_equalTo(CGSizeMake(0.5, 16.5f));
    }];
    
    UIButton *deleteBtn = [UIButton ly_ButtonWithTitle:@"删除" titleColor:gnh_color_theme font:zy_mediumSystemFont15 target:self selector:@selector(deleteBtnClick:)];
    [editView addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(editView).offset(-ORKitMacros.iphoneXSafeHeight/2.0);
        make.centerX.equalTo(editView).offset((kScreenWidth/4.0));
        make.size.mas_equalTo(CGSizeMake(140, 45));
    }];
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isKindOfClass:[PandaMovieWatchRecordDataItem class]]) {
        return [PandaMovieWatchRecordTableViewCell class];
    }
    return nil;
}

#pragma mark - setupData

- (void)setupData
{
    self.navigationItem.title = @"观看历史";
    [FilmFactoryUMConfig analytics:pandazj_me_playHistory label:@"播放历史"];

    CGRect rect = CGRectMake(0, ORKitMacros.statusBarHeight + ORKitMacros.navigationBarHeight, kScreenWidth, kScreenHeight - ORKitMacros.navigationBarHeight - ORKitMacros.statusBarHeight);
    self.tableView.frame = rect;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = gnh_color_b;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([FilmFactoryAccountComponent checkLogin:NO]) {
        self.isNeedPullDownToRefreshAction = YES;
        self.isNeedPullUpToRefreshAction = YES;
    }
    
    // 配置数据
    GNHTableViewSectionObject *sectionObject = [[GNHTableViewSectionObject alloc] init];
    self.sections = [@[sectionObject] mutableCopy];
}

#pragma mark - UITableview Delegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.isEditing) {
        [self.deleteArr mdf_safeAddObject:[self.dataArr mdf_safeObjectAtIndex:indexPath.row]];
        self.deleteNum += 1;
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%@)", @(self.deleteNum)] forState:UIControlStateNormal];
    } else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

        PandaMovieWatchRecordDataItem *cellItem = (PandaMovieWatchRecordDataItem *)[self.dataArr mdf_safeObjectAtIndex:indexPath.row];
        if (self.editView.hidden) {
            // 跳转到视频详情
            [[FilmFactoryPlayerManager sharedInstance] jumpChannelWith:cellItem.idStr type:cellItem.type cover:cellItem.coverImg];
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.editView.hidden) {
        [self.deleteArr mdf_safeRemoveObject:[self.dataArr mdf_safeObjectAtIndex:indexPath.row]];
        self.deleteNum -= 1;
        
        if (self.deleteNum > 0) {
            [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%@)", @(self.deleteNum)] forState:UIControlStateNormal];
        } else {
            [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        }
    }
}

#pragma mark - buttonAction

- (void)rightButtonAction:(UIButton *)btn
{
    [super rightButtonAction:btn];
    
    btn.selected = !btn.selected;
    self.deleteArr = [[NSMutableArray alloc]init];
    self.deleteNum = 0;
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    self.selectedBtn.selected = NO;

    if (btn.selected) {
        self.tableView.editing = YES;
        self.editView.hidden = NO;
        
        CGRect rect = CGRectMake(0, ORKitMacros.statusBarHeight + ORKitMacros.navigationBarHeight, kScreenWidth, kScreenHeight - ORKitMacros.navigationBarHeight - ORKitMacros.statusBarHeight - ORKitMacros.iphoneXSafeHeight - 60);
        self.tableView.frame = rect;
    } else {
        self.tableView.editing = NO;
        self.editView.hidden = YES;
        
        CGRect rect = CGRectMake(0, ORKitMacros.statusBarHeight + ORKitMacros.navigationBarHeight, kScreenWidth, kScreenHeight - ORKitMacros.navigationBarHeight - ORKitMacros.statusBarHeight);
        self.tableView.frame = rect;
    }
}

- (void)selectedBtnClick:(UIButton *)btn
{
    if (!self.selectedBtn.selected) {
        self.selectedBtn.selected = YES;
        
        for (int i = 0; i < self.dataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        [self.deleteArr addObjectsFromArray:self.dataArr];
        self.deleteNum = self.dataArr.count;
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%@)", @(self.deleteNum)] forState:UIControlStateNormal];
    } else {
        self.selectedBtn.selected = NO;
        [self.deleteArr removeAllObjects];
        for (int i = 0; i < self.dataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        self.deleteNum = 0;
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    }
}

- (void)deleteBtnClick:(UIButton *)btn
{
    if (self.tableView.editing) {
        //  你的网络请求
        NSMutableArray *tmpDeleteArr = [NSMutableArray array];
        [self.deleteArr enumerateObjectsUsingBlock:^(__kindof PandaMovieWatchRecordDataItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
            paramDic[@"videoId"] = obj.idStr;
            paramDic[@"type"] = obj.type;
            paramDic[@"watchSeconds"] = @(obj.watchSeconds);
            [tmpDeleteArr mdf_safeAddObject:paramDic];
        }];
        
        if ([FilmFactoryAccountComponent checkLogin:NO]) {
            [self.deleteWatchRecordDataModel PandaMoviedeleteWatchRecordWithData:tmpDeleteArr];
        } else {
            [[FilmFacotryVideoReportManager sharedInstance] deleteVideoHistorey:self.deleteArr];
            
            [self refreshUI];
        }
    }
}

- (void)refreshUI
{
    [self.dataArr removeObjectsInArray:self.deleteArr];
    GNHTableViewSectionObject *sectionObject = self.sections.firstObject;
    sectionObject.items = [self.dataArr mutableCopy];
    [self.tableView reloadData];
    
    // 刷新UI
    self.tableView.editing = NO;
    self.editView.hidden = YES;
    self.editButton.selected = NO;
    CGRect rect = CGRectMake(0, ORKitMacros.statusBarHeight + ORKitMacros.navigationBarHeight, kScreenWidth, kScreenHeight - ORKitMacros.navigationBarHeight - ORKitMacros.statusBarHeight);
    self.tableView.frame = rect;
    
    [self checkNoDataView];
}

#pragma mark - Refresh

- (void)pullDownToRefreshAction
{
    [super pullDownToRefreshAction];
    self.isNeedPullUpToRefreshAction = YES;
        
    self.dataPage = 1;
    
    BOOL flag = [self.watchRecordDataModel fetchWatchRecordWithPage:self.dataPage limit:kDataSize]; // 默认一次性请求个
    if (flag) {
        self.watchRecordDataModel.loadType = GNHDataModelLoadTypeRefresh;
        self.watchRecordDataModel.isShowDefaultView = YES;
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
    BOOL flag = [self.watchRecordDataModel fetchWatchRecordWithPage:self.dataPage limit:kDataSize]; // 默认一次性请求个
    if (flag) {
        self.watchRecordDataModel.loadType = GNHDataModelLoadTypeLoadMore;
    } else {
        self.dataPage = self.preDataPage;
        [self stopPullUpToRefreshAnimation];
    }
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    
    if ([gnhModel isMemberOfClass:[PandaMovieWatchRecordDataModel class]]) {
        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;
        if (gnhModel.loadType == GNHDataModelLoadTypeRefresh) {
            
             // 下拉刷新，数据还原
            [self stopPullDownToRefreshAnimation];
            
            sectionObject.items = [self.watchRecordDataModel.watchRecordItem.list mutableCopy];
        } else {
            // 上拉加载
            NSMutableArray *channelItems = [sectionObject.items mutableCopy];
            [channelItems mdf_safeAddObjectsFromArray:self.watchRecordDataModel.watchRecordItem.list];
            sectionObject.items = [channelItems mutableCopy];
            
            if (self.watchRecordDataModel.watchRecordItem.list.count < self.watchRecordDataModel.watchRecordItem.pageSize) {
                [self reloadDataWithHasMore:NO];
                
                if (!self.watchRecordDataModel.watchRecordItem.list.count) {
                    // 没有数据，刷新页数不变
                    self.dataPage = self.preDataPage;
                }
            } else {
                [self reloadDataWithHasMore:YES];
            }
            
            // 还原选中
            self.selectedBtn.selected = NO;
            [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
            [self.deleteArr removeAllObjects];
        }
        self.dataArr = [sectionObject.items mutableCopy];
        
        // 没有数据
        [self checkNoDataView];
        
        [self.tableView reloadData];
    } else if ([gnhModel isMemberOfClass:[PandaMovieDeleteWatchRecordDataModel class]]) {
        //删除
        [self refreshUI];
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMovieWatchRecordDataModel class]]) {
       [self stopPullDownToRefreshAnimation];
        
        if (gnhModel.loadType == GNHDataModelLoadTypeLoadMore) {
            self.dataPage = self.preDataPage;
            [self stopPullUpToRefreshAnimation];
        }
        
        // 没有数据
        [self checkNoDataView];
    }
}

- (void)checkNoDataView
{
    // 没有数据
    __block BOOL hasData = NO;
    [self.sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GNHTableViewSectionObject *section = (GNHTableViewSectionObject *)obj;
        if (section.items.count) {
            hasData = YES;
            *stop = YES;
        }
    }];
    self.noDataView.hidden = hasData;
}


#pragma mark - Properties

- (PandaMovieWatchRecordDataModel *)watchRecordDataModel
{
    if (!_watchRecordDataModel) {
        _watchRecordDataModel = [self produceModel:[PandaMovieWatchRecordDataModel class]];
    }
    return _watchRecordDataModel;;
}

- (PandaMovieDeleteWatchRecordDataModel *)deleteWatchRecordDataModel
{
    if (!_deleteWatchRecordDataModel) {
        _deleteWatchRecordDataModel = [self produceModel:[PandaMovieDeleteWatchRecordDataModel class]];
    }
    return _deleteWatchRecordDataModel;
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
#pragma mark -- 穿山甲 BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView{
    self.tableView.tableHeaderView = self.tableHeaderView;
}
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error{
    self.tableView.tableHeaderView = nil;
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error{
    self.tableView.tableHeaderView = nil;
}
@end
