//
//  PandaMovieChannelMoreViewController.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/25.
//

#import "PandaMovieChannelMoreViewController.h"
#import "PandaMovieFetchSubChanelMenuDataModel.h"
#import "ORVideoMoreDataModel.h"
#import "ORChannelMoreTableViewCell.h"
#import "PandaMovieH5ViewController.h"
#import "ORChannelNoDataView.h"
#import "PenguinChaseVideoDetailViewController.h"
#define kchannelDataSize  18 // 默认请求18条数据
//
@interface PandaMovieChannelMoreViewController ()
@property (nonatomic, strong) ORVideoMoreDataModel *videoMoreDataModel; // 数据

@property (nonatomic, assign) NSInteger dataPage; // 数据页码
@property (nonatomic, assign) NSInteger preDataPage;
@property (nonatomic, strong) ORChannelNoDataView *noDataView;

@end

@implementation PandaMovieChannelMoreViewController
#define ARC4RANDOM_MAX      0x100000000

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
    self.isNeedPullDownToRefreshAction = YES;
    self.isNeedPullUpToRefreshAction = YES;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = LGDViewBJColor;
    
    // 配置数据
    GNHTableViewSectionObject *sectionObject = [[GNHTableViewSectionObject alloc] init];
    self.sections = [@[sectionObject] mutableCopy];
    [self.tableView reloadData];
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isKindOfClass:[PandaMovieIndexChannelItem class]]) {
        return [ORChannelMoreTableViewCell class];
    }
    
    return nil;
}

- (void)configForCell:(GNHBaseTableViewCell *)cell item:(id)item
{
    if ([item isKindOfClass:[PandaMovieIndexChannelItem class]]) {
        ORChannelMoreTableViewCell *moreTableViewCell = (ORChannelMoreTableViewCell *)cell;
        moreTableViewCell.channelItemCallBack = ^(PandaMovieVideoBaseItem *dataItem) {
            // 详情
            
            if ([[ORNetworkingManager sharedInstance] OssSet]) {
                NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class]];
                int x = arc4random() % dataArr.count;
                PenguinChaseVideoModel *  MypandaModel = [dataArr objectAtIndex:x];
                CGFloat val1 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);
                CGFloat val2 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);
                CGFloat val3 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);
                CGFloat val4 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);
                CGFloat val5 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);

                PenguinChaseVideoModel   * pandaModel = [[PenguinChaseVideoModel alloc]init];
//                pandaModel.pandaMoiveThuburl  = dataItem.coverImg;
//                pandaModel.PandaMoviewName =  dataItem.videoName;
//                pandaModel.PandaMoviewengishName = @"暂无";
//                pandaModel.PandaMoviewType = [NSString stringWithFormat:@"%@/%@",dataItem.typeCh,dataItem.areaTypeCh];
//                pandaModel.PandaMoviewArtiss = dataItem.actor;
//                pandaModel.PandaMoviewstar_five   = val1;
//                pandaModel.PandaMoviewstar_foure  = val2;
//                pandaModel.PandaMoviewstar_three  = val3;
//                pandaModel.PandaMoviewstar_two    = val4;
//                pandaModel.PandaMoviewstar_one   = val5;
//                pandaModel.PandaMoview_isCollected = NO;
//                pandaModel.PandaMoview_listArr = MypandaModel.PandaMoview_listArr;
//                pandaModel.PandaMoview_intrduce = dataItem.videoDesc;
//                pandaModel.PandaMoview_soureNums = [dataItem.idStr integerValue];
//                pandaModel.PandaMoview_DBNums = [dataItem.score floatValue];
//                pandaModel.PandaMovie_ID = MypandaModel.PandaMovie_ID;
//                pandaModel.PandaMoview_tagOne =  dataItem.videoTag;
//                pandaModel.PandaMoview_tagtwo  = @"";
//                pandaModel.time = dataItem.createTime;
//                pandaModel.Top_filmType = 110;
//                pandaModel.total_Num = 12;
                PenguinChaseVideoDetailViewController * FilmDetailVc = [[PenguinChaseVideoDetailViewController alloc]init];
                FilmDetailVc.hidesBottomBarWhenPushed = YES;
                FilmDetailVc.pengModel = pandaModel;
                [self.navigationController pushViewController:FilmDetailVc animated:YES];
            }else{
                [[FilmFactoryPlayerManager sharedInstance] jumpChannelWith:dataItem.idStr type:dataItem.type cover:dataItem.coverImg];
                
            }
            
            
        };
    }
}

#pragma mark - setupData

- (void)setupDatas
{
    self.navigationItem.title = self.sceneName;
    
    self.dataPage = 1;
    
    // 获取数据
    [self pullDownToRefreshAction];
}

#pragma mark - Refresh

- (void)pullDownToRefreshAction
{
    [super pullDownToRefreshAction];
        
    self.dataPage = 1;
    
    BOOL flag = [self.videoMoreDataModel fetchHomeChannelWithPage:self.dataPage limit:kchannelDataSize scene:self.scene sceneType:self.sceneType]; // 默认一次性请求个
    if (flag) {
        self.videoMoreDataModel.loadType = GNHDataModelLoadTypeRefresh;
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
    BOOL flag = [self.videoMoreDataModel fetchHomeChannelWithPage:self.dataPage limit:kchannelDataSize scene:self.scene sceneType:self.sceneType]; // 默认一次性请求个
    if (flag) {
        self.videoMoreDataModel.loadType = GNHDataModelLoadTypeLoadMore;
    } else {
        self.dataPage = self.preDataPage;
        [self stopPullUpToRefreshAnimation];
    }
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    
    if ([gnhModel isMemberOfClass:[ORVideoMoreDataModel class]]) {

        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;

        if (gnhModel.loadType == GNHDataModelLoadTypeRefresh) {
            // 下拉刷新，数据还原
            [self stopPullDownToRefreshAnimation];
            
            PandaMovieIndexChannelItem *cellItem = [[PandaMovieIndexChannelItem alloc] init];
            cellItem.list = [NSMutableArray arrayWithArray:self.videoMoreDataModel.videoMoreItem.list];
            sectionObject.items = [@[cellItem] mutableCopy];
        } else {
            // 上拉加载
            NSMutableArray *channelItems = [sectionObject.items mutableCopy];
            PandaMovieIndexChannelItem *cellItem = channelItems.firstObject;
            [cellItem.list mdf_safeAddObjectsFromArray:self.videoMoreDataModel.videoMoreItem.list];

            sectionObject.items = [@[cellItem] mutableCopy];
            
            if (self.videoMoreDataModel.videoMoreItem.list.count < self.videoMoreDataModel.videoMoreItem.pageSize) {
                [self reloadDataWithHasMore:NO];
                
                if (!self.videoMoreDataModel.videoMoreItem.list.count) {
                    // 没有数据，刷新页数不变
                    self.dataPage = self.preDataPage;
                }
            } else {
                [self reloadDataWithHasMore:YES];
            }
        }
        
        self.noDataView.hidden = YES;
        if (sectionObject.items.count <= 0) {
            self.noDataView.hidden = NO;
        }
        
        [self.tableView reloadData];
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
    if ([gnhModel isMemberOfClass:[ORVideoMoreDataModel class]]) {
        [self stopPullDownToRefreshAnimation];

        if (gnhModel.loadType == GNHDataModelLoadTypeLoadMore) {
            self.dataPage = self.preDataPage;
            [self stopPullUpToRefreshAnimation];
        }
    }
}

#pragma mark - Properties

- (ORVideoMoreDataModel *)videoMoreDataModel
{
    if (!_videoMoreDataModel) {
        _videoMoreDataModel = [self produceModel:[ORVideoMoreDataModel class]];
    }
    return _videoMoreDataModel;
}

- (ORChannelNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[ORChannelNoDataView alloc] init];
        [self.tableView addSubview:_noDataView];
        [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.tableView);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, self.view.height));
        }];
    }
    return _noDataView;
}


@end
