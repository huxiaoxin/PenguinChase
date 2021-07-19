
#import "PandaMovieSettingViewController.h"
#import "PandaMovieSettingTableViewCell.h"
#import <UserNotifications/UserNotifications.h>
#import <SDImageCache.h>

@interface PandaMovieSettingViewController ()

@property (nonatomic, assign) BOOL isPushOn;

@end

@implementation PandaMovieSettingViewController

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

#pragma mark - SetupData

- (void)setupUI
{
    // 配置数据
    GNHTableViewSectionObject *settingSectionObject = [[GNHTableViewSectionObject alloc] init];
    settingSectionObject.didSelectSelector = NSStringFromSelector(@selector(selectCellWithItem:indexPath:));
    settingSectionObject.items = [self dataItems];
    settingSectionObject.isNeedFooterTableViewCell = YES;
    settingSectionObject.footerTableViewCellHeight = 0;

    self.sections = [@[settingSectionObject] mutableCopy];
    [self.tableView reloadData];
    
    self.tableView.tableFooterView = [self setupTableFooterView];
    
    // 计算缓存大小
    // 缓存大小等于 下载的电影 + 图片缓存
    GNHWeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat cashCount = (([[SDImageCache sharedImageCache] totalDiskSize] / 1024.0) / 1024.0);
        cashCount += [self getVideoCacheSize];
        
        GNHTableViewSectionObject *settingSectionObject = self.sections.firstObject;
        [settingSectionObject.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[PandaMovieSettingCellItem class]]) {
                PandaMovieSettingCellItem *cellItem = (PandaMovieSettingCellItem *)obj;
                cellItem.content = [NSString stringWithFormat:@"%.1fM", cashCount];

                [weakSelf.tableView reloadData];
                
                *stop = YES;
            }
        }];
    });
}

- (UIView *)setupTableFooterView
{
    UIView *footerView = [UIView ly_ViewWithColor:gnh_color_d];
    footerView.frame = CGRectMake(0, 0, kScreenWidth, 44.0f+15);
    
    UIButton *logoutBtn = [UIButton ly_ButtonWithTitle:@"退出登录" titleColor:gnh_color_b font:zy_fontSize14 target:self selector:@selector(logoutAction:)];
    logoutBtn.backgroundColor = LGDMianColor;
    logoutBtn.layer.cornerRadius = 22.0f;
    logoutBtn.layer.masksToBounds = YES;
    [footerView addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(footerView).inset(15.0f);
        make.bottom.equalTo(footerView);
    }];
    
    return footerView;
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isKindOfClass:[PandaMovieSettingCellItem class]]) {
        return [PandaMovieSettingTableViewCell class];
    } else if ([item isKindOfClass:[GNHFooterViewTableViewCellItem class]]) {
        return [GNHFooterViewTableViewCell class];
    }
    
    return nil;
}

- (void)configForCell:(GNHBaseTableViewCell *)cell item:(id)item
{
    GNHWeakSelf;
    if ([item isKindOfClass:[PandaMovieSettingCellItem class]]) {
        PandaMovieSettingCellItem *cellItem = (PandaMovieSettingCellItem *)item;
        PandaMovieSettingTableViewCell *settingCell = (PandaMovieSettingTableViewCell *)cell;
        settingCell.settingActionBlock = ^(PandaMovieSettingCellType type, BOOL isOn) {
            if (type == ORSettingCellTypePush) {
                // 消息推送
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                    // 刷新
                    cellItem.isOn = isOn;
                    [weakSelf.tableView reloadData];
                }];
            } else if (type == ORSettingCellTypeNetwork) {
                // 运营网络下载
                [ORUserDefaults setBool:isOn forKey:@"ORNetworkDownloadConfig"];
                [ORUserDefaults synchronize];
                
                // 刷新
                cellItem.isOn = isOn;
                [weakSelf.tableView reloadData];
            }
        };
    }
}

#pragma mark - setupDatas

- (void)setupDatas
{
    // code
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = gnh_color_d;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = gnh_color_d;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)dataItems
{
    NSMutableArray *dataItems = [[NSMutableArray alloc] init];
    PandaMovieSettingCellItem *cellItem1 = [[PandaMovieSettingCellItem alloc] init];
    cellItem1.cellType = ORSettingCellTypeClearMemory;
    cellItem1.title = @"清除缓存";
        
    PandaMovieSettingCellItem *cellItem2 = [[PandaMovieSettingCellItem alloc] init];
    cellItem2.cellType = ORSettingCellTypePush;
    cellItem2.title = @"消息推送";
    cellItem2.isOn = [self fetUserNotification];
        
    PandaMovieSettingCellItem *cellItem3 = [[PandaMovieSettingCellItem alloc] init];
    cellItem3.cellType = ORSettingCellTypeNetwork;
    cellItem3.title = @"运营网络下载";
    cellItem3.isOn = [[ORUserDefaults objectForKey:ORNetworkDownloadConfig] boolValue];
    
    PandaMovieSettingCellItem *cellItem4 = [[PandaMovieSettingCellItem alloc] init];
    cellItem4.cellType = ORSettingCellTypeCheckUpgrade;
    cellItem4.title = @"检查版本";
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    cellItem4.content = dict[@"CFBundleShortVersionString"];
    
    PandaMovieSettingCellItem *cellItem5 = [[PandaMovieSettingCellItem alloc] init];
    cellItem5.cellType = ORSettingCellTypeLogout;
    cellItem5.title = @"账号注销";
        
    [dataItems mdf_safeAddObject:cellItem1];
    [dataItems mdf_safeAddObject:cellItem2];
    [dataItems mdf_safeAddObject:cellItem3];
    [dataItems mdf_safeAddObject:cellItem4];
    [dataItems mdf_safeAddObject:cellItem5];
    
    return dataItems;
}

- (CGFloat)getVideoCacheSize
{
    //得到缓存路径
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"com.SJMediaCacheServer.cache"];
    NSFileManager * manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    //首先判断是否存在缓存文件
    if ([manager fileExistsAtPath:path]) {
        NSArray * childFile = [manager subpathsAtPath:path];
        for (NSString * fileName in childFile) {
            //缓存文件绝对路径
            NSString * absolutPath = [path stringByAppendingPathComponent:fileName];
            size = size + [manager attributesOfItemAtPath:absolutPath error:nil].fileSize;
        }
    }
        
    return [[NSString stringWithFormat:@"%.2f",size / 1024 / 1024] floatValue];
}

- (void)cleanVideoCache
{
    //获取缓存路径
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"com.SJMediaCacheServer.cache"];
    NSFileManager * manager = [NSFileManager defaultManager];
    //判断是否存在缓存文件
    if ([manager fileExistsAtPath:path]) {
        NSArray * childFile = [manager subpathsAtPath:path];
        //逐个删除缓存文件
        for (NSString *fileName in childFile) {
            NSString * absolutPat = [path stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:absolutPat error:nil];
        }
        //删除sdwebimage的缓存
        [[SDImageCache sharedImageCache] clearMemory];
    }
}

- (BOOL)fetUserNotification
{
    __block BOOL isPushOn = NO;
    if (@available(iOS 10.0, *)) {        
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                // 用户未授权通知
                isPushOn = NO;
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                isPushOn = YES;
            }
        }];
    } else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {
            isPushOn = NO;
        } else {
            isPushOn = YES;
        }
    }
    
    return isPushOn;
}

#pragma mark - ButtonAction

- (void)logoutAction:(UIButton *)button
{
    [self gnh_showAlertWithTitle:@"温馨提示" message:@"您确定需要退出登录吗？" appearanceProcess:^(GNHAlertController *alertMaker) {
        alertMaker
        .addActionCancelTitle(@"取消")
        .addActionDefaultTitle(@"确定");
    } actionsBlock:^(NSInteger index, UIAlertAction *action, GNHAlertController *alertMaker) {
        if (index == 1) {
            [ORShareAccountComponent logout];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [FilmFactoryAccountComponent checkLogin:YES];
        }
    }];
}

#pragma mark - UITableview Delegate

- (void)selectCellWithItem:(id<GNHBaseActionItemProtocol>)item indexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([item isKindOfClass:[PandaMovieSettingCellItem class]]) {
        PandaMovieSettingCellItem *cellItem = (PandaMovieSettingCellItem *)item;
        switch (cellItem.cellType) {
            case ORSettingCellTypeClearMemory: { // 清除缓存
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        //清除缓存
                        [[SDImageCache sharedImageCache] clearMemory];
                        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
                        [[NSURLCache sharedURLCache] removeAllCachedResponses];
                                                
                        // 清除视频文件
                        [self cleanVideoCache];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 设置文字
                            [self gnh_showAlertWithTitle:nil message:@"缓存已清除" appearanceProcess:nil actionsBlock:nil];
                            // 刷新
                            cellItem.content = @"0.0M";
                            [self.tableView reloadData];
                        });
                    });
                }];

                break;
            }
            case ORSettingCellTypePush : {  // 消息推送
                break;
            }
            case ORSettingCellTypeNetwork: { // 运营网络下载
               break;
            }
            case ORSettingCellTypeCheckUpgrade: { // 检查版本
                [[ORNetworkingManager sharedInstance] requestBaseUrl:@"" withAddress:@"" params:@{} requesType:ORRequestTypeGet completeBlock:^(id _Nullable responseData, BOOL isSuccess) {
                    
                }];
                [self gnh_showAlertWithTitle:nil message:@"当前已经是最新版本！" appearanceProcess:nil actionsBlock:nil];

                break;
            }
            case ORSettingCellTypeLogout: {  // 账号注销
                [ORShareAccountComponent logout];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                [self gnh_showAlertWithTitle:nil message:@"账号已注销" appearanceProcess:nil actionsBlock:nil];
                
                break;;
            }
                
            default:
                break;
        }
    }
}

@end
