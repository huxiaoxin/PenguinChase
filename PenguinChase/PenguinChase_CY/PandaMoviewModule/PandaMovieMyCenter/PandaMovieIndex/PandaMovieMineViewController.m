

#import "PandaMovieMineViewController.h"
#import "PandaMovieMineTableViewCell.h"
#import "PandaMovieWatchRecordViewController.h"
#import "PandaMovieDownloadViewController.h"
#import "PandaMovieFavoriteViewController.h"
#import "PandaMovieFeedbackViewController.h"
#import "PandaMovieAboutMeViewController.h"
#import "PandaMovieSettingViewController.h"
#import "FilmFactoryUserInformManager.h"
#import "PandaMovieuserInfoController.h"
#import "ORShareTool.h"
#import "PenginChaseMyColltecdViewController.h"
#import "PenguinChaseMyFallowViewController.h"
#import "PenguinChase_MySendViewController.h"
#import "PengUinChaseWatchedViewController.h"
#import <BUAdSDK/BUAdSDK.h>

@interface PandaMovieMineViewController () <FilmFactoryAccountObserver,BUNativeExpressBannerViewDelegate>
@property (nonatomic, strong) PandaMoviewuserInfoItem *userInfoItem;

@property (nonatomic, strong) UIImageView *PandaMovieportrailImageView; // 头像
@property (nonatomic, strong) UILabel *PandaMovienickName; // 昵称
@property (nonatomic, strong) UILabel *PandaMovieloginName;
@property (nonatomic, strong) UILabel *PandaMovieeditLabel; // 编辑


@property (nonatomic, strong) UIButton *PandaMovieplayHistoryButton;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) BUNativeExpressBannerView *bannerAdView;  // banner 广告

@end

@implementation PandaMovieMineViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    [[FilmFactroyAccountNotificationManager sharedInstance] removeObserver:self];
}
#pragma mark - 穿山甲SDK 插屏初始化
-(void)setUpTableSqualData{
 
    // 添加banner广告
    self.bannerAdView = [[BUNativeExpressBannerView alloc] initWithSlotID:@"946261349" rootViewController:self adSize:CGSizeMake(kScreenWidth - 15, 160) interval:30];
    self.bannerAdView.delegate = self;
    [self.view addSubview:self.bannerAdView];
    [self.bannerAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.right.inset(15);
        make.height.mas_equalTo(160.f);
    }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupDatas];
    
    [self setupNotification];
    [self setUpTableSqualData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([FilmFactoryAccountComponent checkLogin:NO]) {
        GNHWeakSelf;
        [[FilmFactoryUserInformManager sharedInstance] updateUserInfo:^(BOOL success, PandaMoviewuserInfoItem *userInfo) {
            // 刷新数据
            if (success) {
                weakSelf.userInfoItem = userInfo;

                [weakSelf refreshData]; // 刷新界面
            }
        }];
        self.PandaMovieeditLabel.hidden = NO;
        self.PandaMovienickName.hidden = NO;
        
        self.PandaMovieloginName.hidden = YES;
    } else {
        
        
        
        
        self.PandaMovieeditLabel.hidden = YES;
        self.PandaMovienickName.hidden = YES;
        self.PandaMovieloginName.hidden = NO;
    }
    [self.downloadButton setTitle:[[ORNetworkingManager sharedInstance] OssSet] ? @"我的发布" : @"我的下载" forState:UIControlStateNormal];
    [self.PandaMovieplayHistoryButton setTitle:[[ORNetworkingManager sharedInstance] OssSet] ? @"浏览历史" : @"播放历史" forState:UIControlStateNormal];
    [self.bannerAdView loadAdData];


 
}

#pragma mark - SetupData

- (void)setupUI
{

    // 修改tableview高度
    CGRect rect = CGRectMake(0, 0, self.tableView.width, self.tableView.height + ORKitMacros.statusBarHeight + ORKitMacros.navigationBarHeight + ORKitMacros.iphoneXSafeHeight);
    
    self.isNeedPullDownToRefreshAction = YES;
    self.tableView.frame = rect;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = LGDViewBJColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 配置数据
    GNHTableViewSectionObject *otherSectionObject = [[GNHTableViewSectionObject alloc] init];
    otherSectionObject.didSelectSelector = NSStringFromSelector(@selector(selectCellWithItem:indexPath:));
    otherSectionObject.items = [self dataItems:0];

    GNHTableViewSectionObject *settingSectionObject = [[GNHTableViewSectionObject alloc] init];
    settingSectionObject.didSelectSelector = NSStringFromSelector(@selector(selectCellWithItem:indexPath:));
    settingSectionObject.items = [self dataItems:1];
    settingSectionObject.gapTableViewCellHeight = 10.0f;
    settingSectionObject.isNeedGapTableViewCell = YES;
    settingSectionObject.isNeedFooterTableViewCell = YES;
    self.sections = [@[otherSectionObject, settingSectionObject] mutableCopy];
    [self.tableView reloadData];
    
    self.tableView.tableHeaderView = [self setupHeaderView];
}

- (UIView *)setupHeaderView
{
    UIView *headerView = [UIView ly_ViewWithColor:LGDViewBJColor];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 37 + kScreenWidth * (240/375.0));
    
    UIImageView *bgImageView = [UIImageView ly_ImageViewWithImageName:@"pandaoview_bj_icon"];
    [headerView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(headerView);
        make.height.mas_offset(kScreenWidth * (240/375.0));
    }];
    
    // top
    // 头像
    UIImageView *PandaMovieportrailImageView = [UIImageView ly_ImageViewWithImageName:@"homelogo"];
    [headerView addSubview:PandaMovieportrailImageView];
    PandaMovieportrailImageView.layer.cornerRadius = 30.5f;
    PandaMovieportrailImageView.layer.masksToBounds = YES;
    [PandaMovieportrailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).offset(90 * (kScreenWidth/375.0));
        make.left.equalTo(headerView).offset(22.0f);
        make.size.mas_equalTo(CGSizeMake(60.0f, 60.0f));
    }];
    self.PandaMovieportrailImageView = PandaMovieportrailImageView;
    
    // 名称
    UILabel *PandaMovienickName = [UILabel ly_LabelWithTitle:@"影视之王" font:zy_mediumSystemFont22 titleColor:gnh_color_b];
    [headerView addSubview:PandaMovienickName];
    PandaMovienickName.textAlignment = NSTextAlignmentLeft;
    [PandaMovienickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(PandaMovieportrailImageView.mas_top).offset(7.5);
        make.left.mas_equalTo(PandaMovieportrailImageView.mas_right).offset(12.0f);
        make.right.equalTo(headerView).offset(-80.0f);
    }];
    self.PandaMovienickName = PandaMovienickName;
    
    // 编辑
    UILabel *PandaMovieeditLabel = [UILabel ly_LabelWithTitle:@"查看并编辑个人资料" font:zy_fontSize12 titleColor:RGBA_HexCOLOR(0xEEEEEE, 1.0)];
    [headerView addSubview:PandaMovieeditLabel];
    PandaMovieeditLabel.textAlignment = NSTextAlignmentLeft;
    [PandaMovieeditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PandaMovienickName);
        make.bottom.mas_equalTo(PandaMovieportrailImageView.mas_bottom).offset(-10.0f);
    }];
    self.PandaMovieeditLabel = PandaMovieeditLabel;
    
    // 立即登录
    UILabel *PandaMovieloginName = [UILabel ly_LabelWithTitle:@"立即登录" font:zy_mediumSystemFont22 titleColor:gnh_color_b];
    [headerView addSubview:PandaMovieloginName];
    PandaMovieloginName.textAlignment = NSTextAlignmentLeft;
    [PandaMovieloginName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(PandaMovieportrailImageView.mas_right).offset(12.0f);
        make.right.equalTo(headerView).offset(-80.0f);
        make.centerY.equalTo(PandaMovieportrailImageView);
    }];
    self.PandaMovieloginName = PandaMovieloginName;
    
    UIImageView *arrImageView = [UIImageView ly_ImageViewWithImageName:@"pandmoview_white_arrow"];
    [headerView addSubview:arrImageView];
    [arrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-25.0f);
        make.centerY.equalTo(PandaMovieportrailImageView);
    }];
    
    UIButton *tapBtn = [[UIButton alloc] init];
    [headerView addSubview:tapBtn];
    [tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.PandaMovieportrailImageView);
            make.left.right.equalTo(headerView);
            make.height.mas_equalTo(100.0f);
    }];
    GNHWeakSelf;
    [tapBtn mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        if ([FilmFactoryAccountComponent checkLogin:YES]) {
            // 编辑资料
            PandaMovieuserInfoController *informVC = [[PandaMovieuserInfoController alloc] init];
            informVC.userInfoItem = weakSelf.userInfoItem;
            [weakSelf.navigationController pushViewController:informVC animated:YES];
        }
    }];
    
    UIView *contentView = [UIView ly_ViewWithColor:[UIColor colorWithHexString:@"292945"]];
    contentView.layer.cornerRadius = 10.0;
    contentView.layer.masksToBounds = YES;
    [headerView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMovieportrailImageView.mas_bottom).offset(27.5);
        make.left.right.equalTo(headerView).inset(15.0f);
        make.height.mas_offset(100.0f);
    }];
    
    
    // 播放历史
    UIButton *PandaMovieplayHistoryButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_redcode_icon" selecteImageName:@"pandaMoview_redcode_icon" target:self selector:@selector(watchHistoryAction:)];
    [PandaMovieplayHistoryButton setTitle:[[ORNetworkingManager sharedInstance] OssSet] ? @"浏览历史" : @"播放历史" forState:UIControlStateNormal];
    [PandaMovieplayHistoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    PandaMovieplayHistoryButton.titleLabel.font = zy_mediumSystemFont13;
    PandaMovieplayHistoryButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [PandaMovieplayHistoryButton setTitleEdgeInsets:UIEdgeInsetsMake(30 ,-30, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [PandaMovieplayHistoryButton setImageEdgeInsets:UIEdgeInsetsMake(-30, 0.0,0.0, -52)]; // 图片高度 （30，30），文字宽度52；
    [contentView addSubview:PandaMovieplayHistoryButton];
    self.PandaMovieplayHistoryButton = PandaMovieplayHistoryButton;
    [PandaMovieplayHistoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(30.0f);
        make.centerY.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(100.0f, 100.0f));
    }];
    
    // 播放历史
    UIButton *collectButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_star_favorite" selecteImageName:@"pandaMoview_star_favorite" target:self selector:@selector(collectAction:)];
    [collectButton setTitle:@"我的收藏" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    collectButton.titleLabel.font = zy_mediumSystemFont13;
    collectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [collectButton setTitleEdgeInsets:UIEdgeInsetsMake(30 ,-30, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [collectButton setImageEdgeInsets:UIEdgeInsetsMake(-30, 0.0,0.0, -52)];
    [contentView addSubview:collectButton];
    [collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(100.0f, 100.0f));
    }];
    
    // 我的下载
    UIButton *downloadButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_Dowload_icon" selecteImageName:@"pandaMoview_Dowload_icon" target:self selector:@selector(downloadAction:)];
    [downloadButton setTitle:[[ORNetworkingManager sharedInstance] OssSet] ? @"我的发布" : @"我的下载" forState:UIControlStateNormal];
    [downloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    downloadButton.titleLabel.font = zy_mediumSystemFont13;
    downloadButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [downloadButton setTitleEdgeInsets:UIEdgeInsetsMake(30 ,-30, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [downloadButton setImageEdgeInsets:UIEdgeInsetsMake(-30, 0.0,0.0, -52)];
    [contentView addSubview:downloadButton];
    self.downloadButton =  downloadButton;
    [downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).offset(-30.0f);
        make.centerY.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(100.0f, 100.0f));
    }];
    
    return headerView;
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isKindOfClass:[PandaMovieMineCellItem class]]) {
        return [PandaMovieMineTableViewCell class];
    } else if ([item isKindOfClass:[GNHFooterViewTableViewCellItem class]]) {
        return [GNHFooterViewTableViewCell class];
    }
    
    return nil;
}

#pragma mark - setupDatas

- (void)setupDatas
{
    // code
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = LGDViewBJColor;
}

- (NSMutableArray *)dataItems:(NSInteger)sectionType
{
    NSMutableArray *dataItems = [[NSMutableArray alloc] init];
    if (sectionType == 0) {
        PandaMovieMineCellItem *cellItem1 = [[PandaMovieMineCellItem alloc] init];
        cellItem1.iconName = @"padnaMoview_feedback_icon";
        cellItem1.cellType = PandaMovieMineCellTypeFeedback;
        cellItem1.title = @"意见反馈";
        cellItem1.isBeginSeperator = YES;
        
        
        PandaMovieMineCellItem *cellItem2 = [[PandaMovieMineCellItem alloc] init];
        cellItem2.iconName = @"padaMoview_share_icon";
        cellItem2.cellType = PandaMovieMineCellTypeShare;
        cellItem2.title = @"应用分享";
        
        PandaMovieMineCellItem *cellItem3 = [[PandaMovieMineCellItem alloc] init];
        cellItem3.iconName = @"pandaMoview_aout_protocl";
        cellItem3.cellType = PandaMovieMineCellTypeAboutMe;
        cellItem3.title = @"关于我们";
        cellItem3.isEndSeperator = YES;
        
        [dataItems mdf_safeAddObject:cellItem1];
        [dataItems mdf_safeAddObject:cellItem2];
        [dataItems mdf_safeAddObject:cellItem3];
    } else {
        PandaMovieMineCellItem *cellItem1 = [[PandaMovieMineCellItem alloc] init];
        cellItem1.iconName = @"pandaMovie_setting_icon";
        cellItem1.cellType = PandaMovieMineCellTypeSetting;
        cellItem1.title = @"设置";
        cellItem1.isBeginSeperator = NO;
        cellItem1.isEndSeperator = YES;
        
        [dataItems mdf_safeAddObject:cellItem1];
        
    }
    
    return dataItems;
}

- (void)refreshData
{
    // 1、更新头部
    [self.PandaMovieportrailImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoItem.avatar] placeholderImage:[UIImage imageNamed:@"homelogo"]];
    self.PandaMovienickName.text = self.userInfoItem.username;
    self.PandaMovieeditLabel.text = [NSString stringWithFormat:@"UID：%@", @(self.userInfoItem.userId).stringValue];
    
    self.PandaMovienickName.hidden = NO;
    self.PandaMovieeditLabel.hidden = NO;
    
    self.PandaMovieloginName.hidden = YES;
}

#pragma mark - ButtonAction

- (void)watchHistoryAction:(UIButton *)btn
{
    
    if ([FilmFactoryAccountComponent checkLogin:YES]) {
        if ([[ORNetworkingManager sharedInstance] OssSet]) {
            PenguinChaseMyFallowViewController * lyFIm = [[PenguinChaseMyFallowViewController alloc]init];
            
            [self.navigationController pushViewController:lyFIm animated:YES];
        }else{
            PandaMovieWatchRecordViewController *watchRecordVC = [[PandaMovieWatchRecordViewController alloc] init];
            [self.navigationController pushViewController:watchRecordVC animated:YES];
        }
    }

}

- (void)collectAction:(UIButton *)btn
{
    if ([FilmFactoryAccountComponent checkLogin:YES]) {

        if ([[ORNetworkingManager sharedInstance] OssSet]) {
            PenginChaseMyColltecdViewController *favoriteVC = [[PenginChaseMyColltecdViewController alloc] init];
            [self.navigationController pushViewController:favoriteVC animated:YES];
            
        }else{
            PandaMovieFavoriteViewController *favoriteVC = [[PandaMovieFavoriteViewController alloc] init];
            [self.navigationController pushViewController:favoriteVC animated:YES];
        }

    }
}

- (void)downloadAction:(UIButton *)btn
{
    if ([FilmFactoryAccountComponent checkLogin:YES]) {
        if ([[ORNetworkingManager sharedInstance] OssSet]) {
            PengUinChaseWatchedViewController *favoriteVC = [[PengUinChaseWatchedViewController alloc] init];
            [self.navigationController pushViewController:favoriteVC animated:YES];
        }else{
            PandaMovieDownloadViewController *downloadVC = [[PandaMovieDownloadViewController alloc] init];
            [self.navigationController pushViewController:downloadVC animated:YES];
        }
       
    }
    
   
}


#pragma mark - Notification

- (void)setupNotification
{
    [[FilmFactroyAccountNotificationManager sharedInstance] registerObserver:self];
}

- (void)handleAccountLogin:(NSDictionary *)userInfo
{
    [self refreshData];
}

- (void)handleAccountLogout:(NSDictionary *)userInfo
{
     // 1、更新头部
    self.PandaMovienickName.hidden = YES;
    self.PandaMovieeditLabel.hidden = YES;
    
    self.PandaMovieloginName.hidden = NO;
}

- (void)handleAccountChanged:(NSDictionary *)userInfo
{
    // 信息已更新，需要重新请求
    GNHWeakSelf;
    [[FilmFactoryUserInformManager sharedInstance] updateUserInfo:^(BOOL success, PandaMoviewuserInfoItem *userInfo) {
        // 刷新数据
        if (success) {
            weakSelf.userInfoItem = userInfo;

            [weakSelf refreshData]; // 刷新界面
        }
    }];
}

#pragma mark - UITableview Delegate

- (void)selectCellWithItem:(id<GNHBaseActionItemProtocol>)item indexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([item isKindOfClass:[PandaMovieMineCellItem class]]) {
        PandaMovieMineCellItem *cellItem = (PandaMovieMineCellItem *)item;
        switch (cellItem.cellType) {
            case PandaMovieMineCellTypeFeedback: { // 意见反馈
                if ([FilmFactoryAccountComponent checkLogin:YES]) {
                    PandaMovieFeedbackViewController *feedbackVC = [[PandaMovieFeedbackViewController alloc] init];
                    [self.navigationController pushViewController:feedbackVC animated:YES];
      
                }
                break;
            }
            case  PandaMovieMineCellTypeShare: {  // 分享
                // 分享，弹出分享框
                [[ORShareTool sharedInstance] shareWithData:@"企鹅追剧"
                                                   imageUrl:@""
                                                description:@"企鹅追剧是一款短视频APP，同时聚合了影视资源，精选内容超过10w+"
                                                 contentUrl:@"https://m.iorange99.com"
                                                  miniappId:@""
                                                miniappPath:@""
                                                 useMiniapp:NO
                                                resultBlock:^(ShareResultType result) {
                    if (result == ShareResultTypeSuccess) {
                        [SVProgressHUD showInfoWithStatus:@"分享成功"];
                    } else {
                        [SVProgressHUD showInfoWithStatus:@"分享失败"];
                    }
                }];
                break;;
            }
            case PandaMovieMineCellTypeAboutMe: { // 关于我们
                PandaMovieAboutMeViewController *aboutMeVC = [[PandaMovieAboutMeViewController alloc] init];
                [self.navigationController pushViewController:aboutMeVC animated:YES];
                break;
            }
            case PandaMovieMineCellTypeSetting: { // 设置
                PandaMovieSettingViewController *settingVC = [[PandaMovieSettingViewController alloc] init];
                [self.navigationController pushViewController:settingVC animated:YES];
                break;
            }
                
            default:
                break;
        }
    }
}

#pragma mark - Refresh

- (void)pullDownToRefreshAction
{
    [super pullDownToRefreshAction];
    
    GNHWeakSelf;
    BOOL flag = [[FilmFactoryUserInformManager sharedInstance] updateUserInfo:^(BOOL success, PandaMoviewuserInfoItem *userInfo) {
        // 刷新数据
        if (success) {
            weakSelf.userInfoItem = userInfo;

            [weakSelf refreshData]; // 刷新界面
        }
        [weakSelf stopPullDownToRefreshAnimation];
    }];
    if (!flag) {
        [weakSelf stopPullDownToRefreshAnimation];
    }
}

#pragma mark - Handle Data

#pragma mark - Properties

#pragma mark -- 穿山甲 BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView{
//    self.tableView.tableHeaderView = self.tableHeaderView;

}
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error{
//    self.tableView.tableHeaderView = nil;
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error{
//    self.tableView.tableHeaderView = nil;
}
@end
