
#import "PandaMovieDiscoveryViewController.h"
#import "PandaMovieSearchViewController.h"
#import "PandaMovieDiscoveryMenuDataModel.h"
#import "PandaMovieDiscoveryDataModel.h"
#import "PandaMovieDiscoveryTableViewCell.h"
#import "PandaMovieChannelNoDataView.h"
#import <YYModel/NSObject+YYModel.h>
#import "PenguinChaseVideoDetailViewController.h"
#import "PenguinChaseVideoModel.h"
#define FilmFactroykDataSize  18 // 默认请求20条数据

@interface PandaMovieDiscoveryViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@property (nonatomic, strong) PandaMovieDiscoveryMenuDataModel *discoveryMenuDataModel;
@property (nonatomic, strong) PandaMovieDiscoveryDataModel *discoveryDataModel;

@property (nonatomic, assign) NSInteger dataPage; // 数据页码
@property (nonatomic, assign) NSInteger preDataPage;

@property (nonatomic, strong) PandaMovieChannelNoDataView *noDataView;

@property (nonatomic, strong) UIButton *typeButton;  // 类型
@property (nonatomic, strong) UIButton *typeSelectedButton;  // 类型

@property (nonatomic, strong) UIButton *areaButton;  // 区域
@property (nonatomic, strong) UIButton *areaSelectedButton;  // 区域

@property (nonatomic, strong) UIButton *yearButton;  // 年份
@property (nonatomic, strong) UIButton *yearSelectedButton;  // 年份

@property (nonatomic, strong) UIButton *childtypeButton;  // 子类型
@property (nonatomic, strong) UIButton *childtypeSelectedButton;  // 子类型

@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *channelName;
@property (nonatomic, copy) NSString *areaId;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *yearId;
@property (nonatomic, copy) NSString *yearName;
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieDiscoveryTypeItem *> *childTypes;
@property (nonatomic, strong) UIScrollView *typeScrollView;  // 子分类scrollview

@property (nonatomic, strong) UIButton *topButton; // 顶部button
@property (nonatomic, strong) UIView *headerView;  // 表头区
@property (nonatomic, assign) BOOL isfilterViewShowed;
@property (nonatomic, assign) CGFloat headerViewHeight; // 表头高度

@end
#define ARC4RANDOM_MAX      0x100000000
@implementation PandaMovieDiscoveryViewController
#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 检测网络
    [self checkNetwork];
}

#pragma mark - setupUI

- (void)setupUI
{
    UIImage * img = [UIImage imageNamed:@"pandaMoview_searching_icon"];
    UIView * rightView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, img.size.width+RealWidth(20), img.size.height+RealWidth(20))];
    UITapGestureRecognizer * rightViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchActionTap)];
    [rightView addGestureRecognizer:rightViewTap];
    MDFButton *searchBtn = [MDFButton buttonWithType:UIButtonTypeCustom];
    searchBtn.touchEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setImage:[UIImage imageNamed:@"pandaMoview_searching_icon"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"pandaMoview_searching_icon"] forState:UIControlStateSelected];
    searchBtn.frame = CGRectMake(RealWidth(10), RealWidth(10), img.size.width, img.size.height);
    [rightView addSubview:searchBtn];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIButton *topButton = [UIButton ly_ButtonWithTitle:@"综合排序" titleColor:LGDMianColor font:zy_blodFontSize15 target:self selector:@selector(showFilterView:)];
    [topButton setImage:[UIImage imageNamed:@"pandaMoview_Down_arrow"] forState:UIControlStateNormal];
    [topButton setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    [topButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];

    topButton.alpha = 0.85;
    topButton.backgroundColor = LGDViewBJColor;
    topButton.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;

    [self.view addSubview:topButton];
    [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.tableView);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 44.0f));
    }];
    self.topButton = topButton;
    self.topButton.hidden = YES;
}
-(void)searchActionTap{
    PandaMovieSearchViewController *searchVC = [[PandaMovieSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
+ (Class)cellClsForItem:(id)item
{
    if ([item isKindOfClass:[PandaMovieDiscoveryItem class]]) {
        return [PandaMovieDiscoveryTableViewCell class];
    }
    return nil;
}

- (void)configForCell:(GNHBaseTableViewCell *)cell item:(id)item
{
    if ([item isKindOfClass:[PandaMovieDiscoveryItem class]]) {
        PandaMovieDiscoveryTableViewCell *discoveryTableViewCell = (PandaMovieDiscoveryTableViewCell *)cell;
        discoveryTableViewCell.pandachannelItemCallBack = ^(PandaMovieDiscoveryDataItem * _Nonnull dataItem) {
            
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

- (void)setupData
{
    self.navigationItem.title = @"发现";
//    self.view.backgroundColor = LGDViewBJColor;
    
    CGRect rect = self.tableView.frame;
    rect.size.height = rect.size.height + ORKitMacros.iphoneXSafeHeight;
    self.tableView.frame = rect;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.isNeedPullDownToRefreshAction = YES;
    self.isNeedPullUpToRefreshAction = YES;
    
    // 配置数据
    GNHTableViewSectionObject *sectionObject = [[GNHTableViewSectionObject alloc] init];
    sectionObject.isNeedGapTableViewCell = YES;
    sectionObject.gapTableViewCellHeight = 6.0f;
    self.sections = [@[sectionObject] mutableCopy];
    
    self.dataPage = 1;
    
    self.channelName = @"全部";
    self.areaName = @"全部";
    self.yearName = @"全部";
    self.typeName = @"全部";
}

- (void)checkNetwork
{
    GNHWeakSelf;
    
    if (self.viewControllerAppearAtFirstTime) {
        // 第一次进入界面
        // 检测网络
        [self hasNetwork:^(bool has) {
            if (!has) {
                // 没有网络
                [SVProgressHUD showInfoWithStatus:@"当前网络不可用，请检测您的网络设置"];
            } else {
                // 获取配置分类
                [weakSelf.discoveryMenuDataModel PandaMoviefetchDiscoveryMenu:@""];
                
                //结束监听
                [weakSelf.manager stopMonitoring];
            }
        }];
    }
}

- (void)hasNetwork:(void(^)(bool has))hasNet
{
    //创建网络监听对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    self.manager = manager;
    //开始监听
    [manager startMonitoring];
    //监听改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                hasNet(NO);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                hasNet(YES);
                break;
        }
    }];
}

- (void)refreshHeaderData
{
    CGFloat gap_offset = 13.0f;
    UIView *headerView = [UIView ly_ViewWithColor:LGDViewBJColor];
    self.headerView = headerView;
    
    // 视频类型
    if (self.discoveryMenuDataModel.discoveryMenuItem.channelTypes.count) {
        UIScrollView *typeScrollView = [UIScrollView ly_ViewWithColor:LGDViewBJColor];
        typeScrollView.showsVerticalScrollIndicator = NO;
        typeScrollView.showsHorizontalScrollIndicator = NO;
        [headerView addSubview:typeScrollView];
        [typeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(gap_offset);
            make.left.equalTo(headerView).offset(10.5f);
            make.right.equalTo(headerView).offset(-11.5f);
            make.height.mas_equalTo(30.0f);
        }];
        
        // 区域
        __block CGFloat areaOrigin_x = 0.0f;
        __block CGFloat areaOrigin_y = 0.0f;
        __block CGRect typeTmpRect = CGRectZero;
        [self.discoveryMenuDataModel.discoveryMenuItem.channelTypes enumerateObjectsUsingBlock:^(__kindof PandaMovieDiscoveryTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *title = obj.name;
            CGSize tagSize = [title textWithSize:13.0f size:CGSizeZero];

            if (typeTmpRect.size.width > 0) {
                areaOrigin_x = CGRectGetMaxX(typeTmpRect) + 10.0f;
                areaOrigin_y = CGRectGetMinY(typeTmpRect);
            }

            UIButton *tagButton = [UIButton ly_ButtonWithTitle:title titleColor:[UIColor whiteColor] font:zy_mediumSystemFont13 target:self selector:@selector(tagButtonAction:)];
            tagButton.frame = CGRectMake(areaOrigin_x, areaOrigin_y, tagSize.width + 30.0f, 30.0f);
            tagButton.tag = 100 + idx;
            tagButton.layer.cornerRadius = 15.0f;
            tagButton.layer.masksToBounds = YES;
            [typeScrollView addSubview:tagButton];
            typeTmpRect = tagButton.frame;
            
            if (idx == 0) {
                self.typeSelectedButton = tagButton;
                self.typeSelectedButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
                [self.typeSelectedButton setTitleColor:LGDMianColor forState:UIControlStateNormal];
//
                
                self.channelId = obj.type;
                self.channelName = obj.name;
            }
        }];
        typeScrollView.contentSize = CGSizeMake(CGRectGetMaxX(typeTmpRect) + 10 , 30.0f);
        gap_offset = gap_offset + CGRectGetMaxY(typeTmpRect) + 10.5;
    }
    
    UIButton *areaButton = [UIButton ly_ButtonWithTitle:@"全部" titleColor:LGDMianColor font:zy_mediumSystemFont13 target:self selector:@selector(buttonAction:)];
    if (self.discoveryMenuDataModel.discoveryMenuItem.areaTypes.count) {
        areaButton.tag = 1;
        areaButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        areaButton.layer.cornerRadius = 15.0f;
        areaButton.layer.masksToBounds = YES;
        [headerView addSubview:areaButton];
        [areaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(gap_offset);
            make.left.equalTo(headerView).offset(10.5f);
            make.size.mas_equalTo(CGSizeMake(55.0f, 30.0f));
        }];
        self.areaButton = areaButton;
        
        UIScrollView *areaScrollView = [UIScrollView ly_ViewWithColor:LGDViewBJColor];
        areaScrollView.showsVerticalScrollIndicator = NO;
        areaScrollView.showsHorizontalScrollIndicator = NO;
        [headerView addSubview:areaScrollView];
        [areaScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(areaButton.mas_right).offset(5);
            make.right.equalTo(headerView).offset(-11.5f);
            make.centerY.equalTo(areaButton);
            make.height.equalTo(areaButton);
        }];
        
        // 区域
        __block CGFloat areaOrigin_x = 10.0f;
        __block CGFloat areaOrigin_y = 0.0f;
        __block CGRect areaTmpRect = CGRectZero;
        [self.discoveryMenuDataModel.discoveryMenuItem.areaTypes enumerateObjectsUsingBlock:^(__kindof PandaMovieDiscoveryTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *title = obj.name;
            CGSize tagSize = [title textWithSize:13.0f size:CGSizeZero];

            if (areaTmpRect.size.width > 0) {
                areaOrigin_x = CGRectGetMaxX(areaTmpRect) + 10.0f;
                areaOrigin_y = CGRectGetMinY(areaTmpRect);
            }

            UIButton *tagButton = [UIButton ly_ButtonWithTitle:title titleColor:[UIColor whiteColor] font:zy_mediumSystemFont13 target:self selector:@selector(tagButtonAction:)];
            tagButton.frame = CGRectMake(areaOrigin_x, areaOrigin_y, tagSize.width + 30.0f, 30.0f);
            tagButton.tag = 200 + idx;
            tagButton.layer.cornerRadius = 15.0f;
            tagButton.layer.masksToBounds = YES;
            [areaScrollView addSubview:tagButton];
            areaTmpRect = tagButton.frame;
        }];
        areaScrollView.contentSize = CGSizeMake(CGRectGetMaxX(areaTmpRect) + 10 , 30.0f);
        gap_offset = gap_offset + CGRectGetMaxY(areaTmpRect) + 10.5;
    }
    
    UIButton *yearButton = [UIButton ly_ButtonWithTitle:@"全部" titleColor:LGDMianColor font:zy_mediumSystemFont13 target:self selector:@selector(buttonAction:)];
    if (self.discoveryMenuDataModel.discoveryMenuItem.yearTypes.count) {
        // 年份
        yearButton.tag = 2;
        yearButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        yearButton.layer.cornerRadius = 15.0f;
        yearButton.layer.masksToBounds = YES;
        [headerView addSubview:yearButton];
        [yearButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(gap_offset);
            make.left.equalTo(headerView).offset(10.5f);
            make.size.mas_equalTo(CGSizeMake(55.0f, 30.0f));
        }];
        self.yearButton = yearButton;
        
        UIScrollView *yearScrollView = [UIScrollView ly_ViewWithColor:LGDViewBJColor];
        yearScrollView.showsVerticalScrollIndicator = NO;
        yearScrollView.showsHorizontalScrollIndicator = NO;
        [headerView addSubview:yearScrollView];
        [yearScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(yearButton.mas_right).offset(5);
            make.right.equalTo(headerView).offset(-11.5f);
            make.centerY.equalTo(yearButton);
            make.height.equalTo(yearButton);
        }];
        
        __block CGFloat yearOrigin_x = 10.0f;
        __block CGFloat yearOrigin_y = 0.0f;
        __block CGRect yearTmpRect = CGRectZero;
        [self.discoveryMenuDataModel.discoveryMenuItem.yearTypes enumerateObjectsUsingBlock:^(__kindof PandaMovieDiscoveryTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *title = obj.name;
            CGSize tagSize = [title textWithSize:13.0f size:CGSizeZero];

            if (yearTmpRect.size.width > 0) {
                yearOrigin_x = CGRectGetMaxX(yearTmpRect) + 10.0f;
                yearOrigin_y = CGRectGetMinY(yearTmpRect);
            }

            UIButton *tagButton = [UIButton ly_ButtonWithTitle:title titleColor:[UIColor whiteColor] font:zy_mediumSystemFont13 target:self selector:@selector(tagButtonAction:)];
            tagButton.frame = CGRectMake(yearOrigin_x, yearOrigin_y, tagSize.width + 30.0f, 30.0f);
            tagButton.tag = 300 + idx;
            tagButton.layer.cornerRadius = 15.0f;
            tagButton.layer.masksToBounds = YES;
            [yearScrollView addSubview:tagButton];
            yearTmpRect = tagButton.frame;
        }];
        yearScrollView.contentSize = CGSizeMake(CGRectGetMaxX(yearTmpRect) + 10 , 30.0f);
        gap_offset = gap_offset + CGRectGetMaxY(yearTmpRect) + 10.5;
    }
    
    UIButton *childtypeButton = [UIButton ly_ButtonWithTitle:@"全部" titleColor:LGDMianColor font:zy_mediumSystemFont13 target:self selector:@selector(buttonAction:)];
    if (self.discoveryMenuDataModel.discoveryMenuItem.types.count) {
        // 类型
        childtypeButton.tag = 3;
        childtypeButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        childtypeButton.layer.cornerRadius = 15.0f;
        childtypeButton.layer.masksToBounds = YES;
        [headerView addSubview:childtypeButton];
        [childtypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(gap_offset);
            make.left.equalTo(headerView).offset(10.5f);
            make.size.mas_equalTo(CGSizeMake(55.0f, 30.0f));
        }];
        self.childtypeButton = childtypeButton;
        
        UIScrollView *typeScrollView = [UIScrollView ly_ViewWithColor:LGDViewBJColor];
        typeScrollView.showsVerticalScrollIndicator = NO;
        typeScrollView.showsHorizontalScrollIndicator = NO;
        [headerView addSubview:typeScrollView];
        [typeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(childtypeButton.mas_right).offset(5);
            make.right.equalTo(headerView).offset(-11.5f);
            make.centerY.equalTo(childtypeButton);
            make.height.equalTo(childtypeButton);
        }];
        self.typeScrollView = typeScrollView;
        
        __block CGFloat typeOrigin_x = 10.0f;
        __block CGFloat typeOrigin_y = 0.0f;
        __block CGRect typeTmpRect = CGRectZero;
        
        NSArray *types = self.discoveryMenuDataModel.discoveryMenuItem.types[self.channelId];
        types = [[NSArray yy_modelArrayWithClass:[PandaMovieDiscoveryTypeItem class] json:types] mutableCopy];
        NSMutableArray <__kindof PandaMovieDiscoveryTypeItem *> *childTypes = [NSMutableArray arrayWithArray:types];
        self.childTypes = childTypes;
        [childTypes enumerateObjectsUsingBlock:^(__kindof PandaMovieDiscoveryTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *title = obj.name;
            CGSize tagSize = [title textWithSize:13.0f size:CGSizeZero];

            if (typeTmpRect.size.width > 0) {
                typeOrigin_x = CGRectGetMaxX(typeTmpRect) + 10.0f;
                typeOrigin_y = CGRectGetMinY(typeTmpRect);
            }

            UIButton *tagButton = [UIButton ly_ButtonWithTitle:title titleColor:[UIColor whiteColor] font:zy_mediumSystemFont13 target:self selector:@selector(tagButtonAction:)];
            tagButton.frame = CGRectMake(typeOrigin_x, typeOrigin_y, tagSize.width + 30.0f, 30.0f);
            tagButton.tag = 400 + idx;
            tagButton.layer.cornerRadius = 15.0f;
            tagButton.layer.masksToBounds = YES;
            [typeScrollView addSubview:tagButton];
            typeTmpRect = tagButton.frame;
        }];
        typeScrollView.contentSize = CGSizeMake(CGRectGetMaxX(typeTmpRect) + 10 , 30.0f);
        gap_offset += CGRectGetMaxY(typeTmpRect);
    }
    
    headerView.frame = CGRectMake(0, 0, kScreenWidth, gap_offset + 14.0f);
    self.tableView.tableHeaderView = headerView;
    self.headerViewHeight = gap_offset + 14.0f;
    
    // 请求数据
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"videoType"] = self.channelId;
    paramsDic[@"areaType"] = self.areaId;
    paramsDic[@"yearType"] = self.yearId;
    paramsDic[@"childType"] = self.typeId;
    
    
    [self.discoveryDataModel PandaMoviefetchDiscoverChannelWithPage:self.dataPage
                                               PandaMovielimit:FilmFactroykDataSize
                                              PandaMovieparams:paramsDic];
    self.discoveryDataModel.loadType = GNHDataModelLoadTypeRefresh;
}

- (void)refreshChildTypeView
{
    if (self.discoveryMenuDataModel.discoveryMenuItem.types.count) {
        // 类型
        __block CGFloat typeOrigin_x = 10.0f;
        __block CGFloat typeOrigin_y = 0.0f;
        __block CGRect typeTmpRect = CGRectZero;
        
        for (UIView *subView in self.typeScrollView.subviews) {
            [subView removeFromSuperview];
        }
        [self.childTypes enumerateObjectsUsingBlock:^(__kindof PandaMovieDiscoveryTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *title = obj.name;
            CGSize tagSize = [title textWithSize:13.0f size:CGSizeZero];

            if (typeTmpRect.size.width > 0) {
                typeOrigin_x = CGRectGetMaxX(typeTmpRect) + 10.0f;
                typeOrigin_y = CGRectGetMinY(typeTmpRect);
            }

            UIButton *tagButton = [UIButton ly_ButtonWithTitle:title titleColor:[UIColor whiteColor] font:zy_mediumSystemFont13 target:self selector:@selector(tagButtonAction:)];
            tagButton.frame = CGRectMake(typeOrigin_x, typeOrigin_y, tagSize.width + 30.0f, 30.0f);
            tagButton.tag = 400 + idx;
            tagButton.layer.cornerRadius = 15.0f;
            tagButton.layer.masksToBounds = YES;
            [self.typeScrollView addSubview:tagButton];
            typeTmpRect = tagButton.frame;
        }];
        self.typeScrollView.contentSize = CGSizeMake(CGRectGetMaxX(typeTmpRect) + 10 , 30.0f);
    }
}

#pragma mark - buttonAction

- (void)searchAction:(UIButton *)btn
{
    PandaMovieSearchViewController *searchVC = [[PandaMovieSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)showFilterView:(UIButton *)btn
{
    [self.view addSubview:self.headerView];
    
    // 停止滚动
    [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];

    // 弹出动画
    [UIView animateWithDuration:0.3 animations:^{
        self.topButton.hidden = YES;
        self.headerView.frame = CGRectMake(0, ORKitMacros.navigationBarHeight + ORKitMacros.statusBarHeight, kScreenWidth, self.headerViewHeight);
        
        self.isfilterViewShowed = YES;
    }];
}

- (void)buttonAction:(UIButton *)btn
{
    [self.tableView setContentOffset:CGPointZero animated:NO];
    if (btn.tag == 1) {
        // 区域全部
        if (!self.areaId) {
            return;
        }
        
        self.areaSelectedButton.backgroundColor = LGDViewBJColor;
        [self.areaSelectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.areaSelectedButton = btn;
        self.areaButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        [self.areaButton setTitleColor:LGDMianColor forState:UIControlStateNormal];
        
        self.areaId = nil;
        self.areaName = @"全部";
    } else if (btn.tag == 2) {
        // 年份全部
        if (!self.yearId) {
            return;
        }
        
        self.yearSelectedButton.backgroundColor = LGDViewBJColor;
        [self.yearSelectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.yearSelectedButton = btn;
        self.yearButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        [self.yearButton setTitleColor:LGDMianColor forState:UIControlStateNormal];
        
        self.yearId = nil;
        self.yearName = @"全部";
    }  else if (btn.tag == 3) {
        // 类型全部
        if (!self.typeId) {
            return;
        }
        
        self.childtypeSelectedButton.backgroundColor = LGDViewBJColor;
        [self.childtypeSelectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.childtypeSelectedButton = btn;
        self.childtypeButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        [self.childtypeButton setTitleColor:LGDMianColor forState:UIControlStateNormal];
        
        self.typeId = nil;
        self.typeName = @"全部";
    }
    
    self.dataPage = 1;
    self.preDataPage = 1;
    
    // 调用接口
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"videoType"] = self.channelId;
    paramsDic[@"areaType"] = self.areaId;
    paramsDic[@"yearType"] = self.yearId;
    paramsDic[@"childType"] = self.typeId;
    [self.discoveryDataModel PandaMoviefetchDiscoverChannelWithPage:self.dataPage
                                               PandaMovielimit:FilmFactroykDataSize
                                              PandaMovieparams:paramsDic];
    self.discoveryDataModel.loadType = GNHDataModelLoadTypeRefresh;
}

- (void)tagButtonAction:(UIButton *)btn
{
    GNHWeakSelf;
    [self.tableView setContentOffset:CGPointZero animated:NO];
    if (btn.tag >= 100 && btn.tag < 200 ) {
        // 区域
        if ([self.typeSelectedButton isEqual:btn]) {
            return;
        }
        
        self.typeSelectedButton.backgroundColor = LGDViewBJColor;
        [self.typeSelectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.typeSelectedButton = btn;
        self.typeSelectedButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        [self.typeSelectedButton setTitleColor:LGDMianColor forState:UIControlStateNormal];
        
        [self.discoveryMenuDataModel.discoveryMenuItem.channelTypes enumerateObjectsUsingBlock:^(__kindof PandaMovieDiscoveryTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == btn.tag - 100) {
                weakSelf.channelId = obj.type;
                weakSelf.channelName = obj.name;
                *stop = YES;
            }
        }];
        
        NSArray *types = self.discoveryMenuDataModel.discoveryMenuItem.types[self.channelId];
        types = [[NSArray yy_modelArrayWithClass:[PandaMovieDiscoveryTypeItem class] json:types] mutableCopy];
        self.childTypes = [NSMutableArray arrayWithArray:types];
        
        // 刷新对应的子分类
        [self refreshChildTypeView];
        
        self.childtypeButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        [self.childtypeButton setTitleColor:LGDMianColor forState:UIControlStateNormal];
        self.typeId = nil;
        self.typeName = @"全部";
    } else if (btn.tag >= 200 && btn.tag < 300 ) {
        // 区域
        if ([self.areaSelectedButton isEqual:btn]) {
            return;
        }
        self.areaSelectedButton.backgroundColor = LGDViewBJColor;
        [self.areaSelectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.areaSelectedButton = btn;
        self.areaSelectedButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        [self.areaSelectedButton setTitleColor:LGDMianColor forState:UIControlStateNormal];
        
        self.areaButton.backgroundColor = LGDViewBJColor;
        [self.areaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.discoveryMenuDataModel.discoveryMenuItem.areaTypes enumerateObjectsUsingBlock:^(__kindof PandaMovieDiscoveryTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == btn.tag - 200) {
                weakSelf.areaId = obj.type;
                weakSelf.areaName = obj.name;
                *stop = YES;
            }
        }];
    } else if (btn.tag >= 300 && btn.tag < 400) {
        // 年份
        if ([self.yearSelectedButton isEqual:btn]) {
            return;
        }
        self.yearSelectedButton.backgroundColor = LGDViewBJColor;
        [self.yearSelectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.yearSelectedButton = btn;
        self.yearSelectedButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        [self.yearSelectedButton setTitleColor:LGDMianColor forState:UIControlStateNormal];
        
        self.yearButton.backgroundColor = LGDViewBJColor;
        [self.yearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.discoveryMenuDataModel.discoveryMenuItem.yearTypes enumerateObjectsUsingBlock:^(__kindof PandaMovieDiscoveryTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == btn.tag - 300) {
                weakSelf.yearId = obj.type;
                weakSelf.yearName = obj.name;
                *stop = YES;
            }
        }];
    } else if (btn.tag >= 400) {
        // 类型
        if ([self.childtypeSelectedButton isEqual:btn]) {
            return;
        }
        self.childtypeSelectedButton.backgroundColor = LGDViewBJColor;
        [self.childtypeSelectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.childtypeSelectedButton = btn;
        self.childtypeSelectedButton.backgroundColor = [UIColor colorWithHexString:@"#21C47D" Alpha:0.2];
        [self.childtypeSelectedButton setTitleColor:LGDMianColor forState:UIControlStateNormal];
        
        self.childtypeButton.backgroundColor = LGDViewBJColor;
        [self.childtypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.childTypes enumerateObjectsUsingBlock:^(__kindof PandaMovieDiscoveryTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == btn.tag - 400) {
                weakSelf.typeId = obj.type;
                weakSelf.typeName = obj.name;
                *stop = YES;
            }
        }];
    }
    
    self.dataPage = 1;
    self.preDataPage = 1;
    
    // 调用接口
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"videoType"] = self.channelId;
    paramsDic[@"areaType"] = self.areaId;
    paramsDic[@"yearType"] = self.yearId;
    paramsDic[@"childType"] = self.typeId;
    [self.discoveryDataModel PandaMoviefetchDiscoverChannelWithPage:self.dataPage
                                               PandaMovielimit:FilmFactroykDataSize
                                              PandaMovieparams:paramsDic];
    self.discoveryDataModel.loadType = GNHDataModelLoadTypeRefresh;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset_y = scrollView.contentOffset.y;
    if (offset_y >= self.tableView.tableHeaderView.height) {
        self.topButton.hidden = NO;
        
        NSString *title = [NSString stringWithFormat:@"%@.%@.%@.%@", self.channelName,self.areaName,self.yearName,self.typeName];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title];
        [string addAttribute:NSFontAttributeName
                       value:zy_blodFontSize15
                       range:NSMakeRange(0, self.channelName.length)];
        [string addAttribute:NSBaselineOffsetAttributeName
                       value:[NSNumber numberWithFloat:3.0]
                       range:NSMakeRange(self.channelName.length, 1)];
        [string addAttribute:NSFontAttributeName
                       value:zy_blodFontSize15
                       range:NSMakeRange(self.channelName.length + 1, self.areaName.length)];
        [string addAttribute:NSBaselineOffsetAttributeName
                       value:[NSNumber numberWithFloat:3.0]
                       range:NSMakeRange(self.channelName.length + self.areaName.length + 1, 1)];
        [string addAttribute:NSFontAttributeName
                       value:zy_blodFontSize15
                       range:NSMakeRange(self.channelName.length + self.areaName.length + 1 + 1, self.yearName.length)];
        [string addAttribute:NSBaselineOffsetAttributeName
                       value:[NSNumber numberWithFloat:3.0]
                       range:NSMakeRange(self.channelName.length + self.areaName.length + self.yearName.length + 1 + 1, 1)];
        [string addAttribute:NSFontAttributeName
                       value:zy_blodFontSize15
                       range:NSMakeRange(self.channelName.length + self.areaName.length + self.yearName.length + 1 + 1 + 1, self.typeName.length)];

        [self.topButton setAttributedTitle:string forState:UIControlStateNormal];
//        [self.topButton setTitle:title forState:UIControlStateNormal];
    } else {
        self.topButton.hidden = YES;
    }
    
    if (self.isfilterViewShowed) {
        self.tableView.tableHeaderView = nil;
        self.headerView.frame = CGRectMake(0, 0, kScreenWidth, self.headerViewHeight);
        self.tableView.tableHeaderView = self.headerView;
        
        self.isfilterViewShowed = NO;
    }
}

#pragma mark - Refresh

- (void)pullDownToRefreshAction
{
    [super pullDownToRefreshAction];
        
    self.dataPage = 1;
    
    // 请求数据
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"videoType"] = self.channelId;
    paramsDic[@"areaType"] = self.areaId;
    paramsDic[@"yearType"] = self.yearId;
    paramsDic[@"childType"] = self.typeId;

    BOOL flag = [self.discoveryDataModel PandaMoviefetchDiscoverChannelWithPage:self.dataPage PandaMovielimit:FilmFactroykDataSize PandaMovieparams:paramsDic];
    if (flag) {
        self.discoveryDataModel.loadType = GNHDataModelLoadTypeRefresh;
        self.discoveryDataModel.isShowDefaultView = YES;
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
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"videoType"] = self.channelId;
    paramsDic[@"areaType"] = self.areaId;
    paramsDic[@"yearType"] = self.yearId;
    paramsDic[@"childType"] = self.typeId;
    BOOL flag = [self.discoveryDataModel PandaMoviefetchDiscoverChannelWithPage:self.dataPage PandaMovielimit:FilmFactroykDataSize PandaMovieparams:paramsDic];
    if (flag) {
        self.discoveryDataModel.loadType = GNHDataModelLoadTypeLoadMore;
    } else {
        self.dataPage = self.preDataPage;
        [self stopPullUpToRefreshAnimation];
    }
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    
    if ([gnhModel isMemberOfClass:[PandaMovieDiscoveryMenuDataModel class]]) {
        [self refreshHeaderData];
    } else if ([gnhModel isMemberOfClass:[PandaMovieDiscoveryDataModel class]]) {
        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;

        if (gnhModel.loadType == GNHDataModelLoadTypeRefresh) {
             // 下拉刷新，数据还原
            [self stopPullDownToRefreshAnimation];
            PandaMovieDiscoveryItem *discoveryItem = [[PandaMovieDiscoveryItem alloc] init];
            discoveryItem.list = [self.discoveryDataModel.discoveryItem.list mutableCopy];
            sectionObject.items = [@[discoveryItem] mutableCopy];
        } else {
            // 上拉加载
            NSMutableArray *channelItems = [sectionObject.items mutableCopy];
            PandaMovieDiscoveryItem *discoveryItem = channelItems.firstObject;
            [discoveryItem.list mdf_safeAddObjectsFromArray:self.discoveryDataModel.discoveryItem.list];
            sectionObject.items = [@[discoveryItem] mutableCopy];
            
            if (self.discoveryDataModel.discoveryItem.list.count < FilmFactroykDataSize) {
                [self reloadDataWithHasMore:NO];
                
                if (!self.discoveryDataModel.discoveryItem.list.count) {
                    // 没有数据，刷新页数不变
                    self.dataPage = self.preDataPage;
                }
            } else {
                [self reloadDataWithHasMore:YES];
            }
        }
        
        // 没有数据
        NSMutableArray *channelItems = [sectionObject.items mutableCopy];
        PandaMovieDiscoveryItem *discoveryItem = (PandaMovieDiscoveryItem *)channelItems.firstObject;
        if (!discoveryItem.list.count) {
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
    if ([gnhModel isMemberOfClass:[PandaMovieDiscoveryDataModel class]]) {
       [self stopPullDownToRefreshAnimation];
        
        if (self.discoveryDataModel.loadType == GNHDataModelLoadTypeLoadMore) {
            [self stopPullUpToRefreshAnimation];
        }
        
        // 没有数据
        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;
        NSMutableArray *channelItems = [sectionObject.items mutableCopy];
        PandaMovieDiscoveryItem *discoveryItem = (PandaMovieDiscoveryItem *)channelItems.firstObject;
        if (!discoveryItem.list.count) {
            self.noDataView.hidden = NO;
        } else {
            self.noDataView.hidden = YES;
        }
    }
}

#pragma mark - Properties

- (PandaMovieChannelNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[PandaMovieChannelNoDataView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.tableView.tableHeaderView.frame), kScreenWidth,  self.tableView.height - CGRectGetHeight(self.tableView.tableHeaderView.frame))];
        [self.tableView addSubview:_noDataView];
    }
    return _noDataView;
}

- (PandaMovieDiscoveryDataModel *)discoveryDataModel
{
    if (!_discoveryDataModel) {
        _discoveryDataModel = [self produceModel:[PandaMovieDiscoveryDataModel class]];
    }
    return _discoveryDataModel;
}

- (PandaMovieDiscoveryMenuDataModel *)discoveryMenuDataModel
{
    if (!_discoveryMenuDataModel) {
        _discoveryMenuDataModel = [self produceModel:[PandaMovieDiscoveryMenuDataModel class]];
    }
    return _discoveryMenuDataModel;
}

@end
