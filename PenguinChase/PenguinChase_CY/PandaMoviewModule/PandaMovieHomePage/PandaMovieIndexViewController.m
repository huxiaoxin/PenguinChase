//
//  ORIndexViewController.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/8.
//

#import "PandaMovieIndexViewController.h"
#import <VTMagic.h>
#import <VTMagicProtocol.h>
#import "PandaMovieChannelViewController.h"
#import <AFNetworkReachabilityManager.h>
#import "PandaMovieSearchViewController.h"
#import "PandaMovieFetchChannelMenuDataModel.h"
#import "GNHBaseTextField.h"
#import "PandaMovieWatchRecordViewController.h"
#import "PandaMovieDownloadViewController.h"
#import "PandaMovieCategoryViewController.h"
#import "FilmFactoryUpgradeManager.h"

@interface PandaMovieIndexViewController () <VTMagicViewDataSource, VTMagicViewDelegate, VTMagicReuseProtocol, UITextFieldDelegate>

@property (strong, nonatomic) VTMagicController *magicController;
@property (nonatomic, strong) NSMutableArray *matchTypes; // 分类赛事
@property (nonatomic, strong) NSMutableArray *menuTitles; // 分类赛事标题
@property (nonatomic, assign) NSInteger currentType;

@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@property (nonatomic, strong) PandaMovieFetchChannelMenuDataModel *fetchChannelMenuDataModel; // 主菜单

@property (nonatomic, strong) GNHBaseTextField *searchTextField; // 搜索框

@end

@implementation PandaMovieIndexViewController

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
    
    // 检测网络
    [self checkNetwork];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - setupUI

- (void)setupUI
{
    // 顶部View
    [self setupHeaderView];
    
    // 添加分类赛事
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchTextField.mas_bottom).offset(5);
        make.left.right.bottom.equalTo(self.view);
    }];

    MDFButton *categoryButton = [[MDFButton alloc] initWithFrame:CGRectMake(0, 0, 58, 44)];
    categoryButton.backgroundColor = LGDViewBJColor;
    [categoryButton setImage:[UIImage imageNamed:@"index_category"] forState:UIControlStateNormal];
    categoryButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 15);
    [categoryButton addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
    self.magicController.magicView.rightNavigatoinItem = categoryButton;
}
-(void)logoImageviewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setupHeaderView
{
    CGFloat origin_y = kGNHStatusBarHeight + 30.0f;
    if ([UIDevice ly_hasFringeScreen]) {
        origin_y = kGNHStatusBarHeight + 15;
    }
    
    UIImage * myImg = [UIImage imageNamed:@"pandaMoview_leff_white_arrow"];
    UIImageView *logoImageview = [UIImageView ly_ImageViewWithImageName:@"pandaMoview_leff_white_arrow"];
    logoImageview.userInteractionEnabled = YES;
    [self.view addSubview:logoImageview];
    [logoImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10.0f);
        make.top.offset(origin_y);
        make.size.mas_equalTo(myImg.size);
    }];
    
    UITapGestureRecognizer * myBacktap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logoImageviewClick)];
    
    [logoImageview addGestureRecognizer:myBacktap];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    //搜索框
    GNHBaseTextField *searchTextField = [[GNHBaseTextField alloc] initWithFrame:CGRectMake(20 + CGRectGetMaxX(logoImageview.frame), CGRectGetMidY(logoImageview.frame)-15, kScreenWidth - (20 + CGRectGetMaxX(logoImageview.frame) + 42), 30)];
    searchTextField.delegate = self;
    searchTextField.backgroundColor = gnh_color_c;
    searchTextField.font = zy_fontSize13;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    searchTextField.layer.cornerRadius = 15;
    searchTextField.layer.masksToBounds = YES;
    searchTextField.leftViewGap = 9.0f;
    searchTextField.textRectLeftGap = 6.5f;
    searchTextField.editingRectLeftGap = 6.5f;
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:@"搜索电影" attributes:@{NSFontAttributeName:zy_fontSize13, NSForegroundColorAttributeName:RGBA_HexCOLOR(0x929296, 1.0)}];
    [searchTextField setAttributedPlaceholder:attr];
    searchTextField.clipsToBounds = YES;
    [searchTextField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:searchTextField];
    self.searchTextField = searchTextField;
    // 搜索图标 com_search
    UIImage *image = [UIImage imageNamed:@"pandaMoview_searching_icon"];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:image];
    iconImageView.frame = CGRectMake(9, 0, 15.0f, 15.0f);
    searchTextField.leftView = iconImageView;
    
//    UIButton *historyButton = [UIButton ly_ButtonWithTitle:@"" titleColor:nil font:nil target:self selector:@selector(historyRecord:)];
//    [historyButton setImage:[UIImage imageNamed:@"index_history"] forState:UIControlStateNormal];
//    [self.view addSubview:historyButton];
//    [historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(searchTextField.mas_right).offset(7.0f);
//        make.right.equalTo(self.view).offset(-10.0f);
//        make.centerY.equalTo(searchTextField);
//        make.size.mas_equalTo(CGSizeMake(24.0f, 24.0f));
//    }];
}

#pragma mark - SetupData

- (void)setupDatas
{
    self.fd_prefersNavigationBarHidden = YES;

    // 版本检测
    [FilmFactoryUpgradeManager sharedInstance];
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
                // 获取频道分类
                [weakSelf.fetchChannelMenuDataModel fetchChannelMenuWithScene:@"home"];
                
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

#pragma mark - Notification

- (void)setupNotifications
{
    [super setupNotifications];
}

#pragma mark - ButtonAction

- (void)historyRecord:(UIButton *)button
{
    // 观看记录
    PandaMovieWatchRecordViewController *watchRecordVC = [[PandaMovieWatchRecordViewController alloc] init];
    [self.navigationController pushViewController:watchRecordVC animated:YES];
}

- (void)downloadButton:(UIButton *)button
{
    // 下载
    if ([FilmFactoryAccountComponent checkLogin:YES]) {
        PandaMovieDownloadViewController *downloadVC = [[PandaMovieDownloadViewController alloc] init];
        [self.navigationController pushViewController:downloadVC animated:YES];
    }
}
//
- (void)textFieldAction:(id)sender
{
    // 搜索
    PandaMovieSearchViewController *searchVC = [[PandaMovieSearchViewController alloc] init];
    searchVC.videotype = @"all";
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)categoryAction:(UIButton *)button
{
    // 频道
    GNHWeakSelf;
    PandaMovieCategoryViewController *categoryVC = [[PandaMovieCategoryViewController alloc] init];
    categoryVC.data = self.fetchChannelMenuDataModel.channelMenuItem.data;
    categoryVC.categoryCompleteHandel = ^(PandaMovieChannelMenuDataItem * _Nonnull item) {
    [weakSelf.matchTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    PandaMovieChannelMenuDataItem *dataItem = (PandaMovieChannelMenuDataItem *)obj;
            if ([dataItem.type isEqualToString:item.type]) {
                [weakSelf.magicController.magicView reloadDataToPage:idx];
                *stop = YES;
            }
        }];
    };
    [self.navigationController pushViewController:categoryVC animated:YES];
}

#pragma mark - VTMagicViewDataSource

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return self.menuTitles;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"item.identifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        MDFButton *fontButton = [[MDFButton alloc] init];
        fontButton.normalFont = zy_mediumSystemFont15;
        fontButton.selectedFont = zy_blodFontSize17;
        menuItem = fontButton;
        
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:LGDMianColor forState:UIControlStateSelected];
    }
    [menuItem setImage:nil forState:UIControlStateNormal];
    [menuItem setImage:nil forState:UIControlStateSelected];
    menuItem.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    NSString *pageId = [NSString stringWithFormat:@"page.identifier_%@",@(pageIndex)];
    PandaMovieChannelViewController *detailViewController = [magicView dequeueReusablePageWithIdentifier:pageId];
    if (!detailViewController) {
        detailViewController = [[PandaMovieChannelViewController alloc] init];
    }
    PandaMovieChannelMenuDataItem *dataItem = [self.matchTypes mdf_safeObjectAtIndex:pageIndex];
    detailViewController.typeId = dataItem.type;
    return detailViewController;
}

#pragma mark - VTMagicViewDelegate

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex
{
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex
{
    [self.magicController.magicView reselectMenuItem];
    self.magicController.magicView.sliderHidden = NO;
}

#pragma mark - Handle Data

- (void)reloadChannelData
{
    self.matchTypes = [NSMutableArray arrayWithArray:self.fetchChannelMenuDataModel.channelMenuItem.data];
    
    // 标题
    NSMutableArray *menuTitles = [NSMutableArray array];
    
    [self.matchTypes enumerateObjectsUsingBlock:^(PandaMovieChannelMenuDataItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [menuTitles mdf_safeAddObject:obj.name];
    }];
    self.menuTitles = [menuTitles mutableCopy];
    
    [self.magicController.magicView reloadDataToPage:0];
}

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    
    if ([gnhModel isMemberOfClass:[PandaMovieFetchChannelMenuDataModel class]]) {
        [self reloadChannelData];
        
        // 存储数据
        [FilmFactoryMenuChannelManager sharedInstance].channelMenuItem = self.fetchChannelMenuDataModel.channelMenuItem;
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
}

#pragma mark - Properties

- (UIViewController<VTMagicProtocol> *)magicController
{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
    
        _magicController.magicView.layoutStyle = VTLayoutStyleDefault;
        _magicController.magicView.navigationInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _magicController.magicView.navigationColor = [UIColor clearColor];
        _magicController.magicView.navigationHeight = 44;
        _magicController.magicView.separatorHidden = YES;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.itemWidth = 60.0f;
        _magicController.magicView.sliderColor = gnh_color_theme;
        _magicController.magicView.sliderWidth = 15;
        _magicController.magicView.sliderHeight = 3;
        _magicController.magicView.sliderOffset = -5;
        
        // 自定义滑块
        UIView *sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 15, 3)];
        sliderView.layer.cornerRadius = 1.5f;
        sliderView.layer.masksToBounds = YES;
        [_magicController.magicView setSliderView:sliderView];
        
    }
    return _magicController;
}

- (PandaMovieFetchChannelMenuDataModel *)fetchChannelMenuDataModel
{
    if (!_fetchChannelMenuDataModel) {
        _fetchChannelMenuDataModel = [self produceModel:[PandaMovieFetchChannelMenuDataModel class]];
    }
    return _fetchChannelMenuDataModel;
}
      
@end

