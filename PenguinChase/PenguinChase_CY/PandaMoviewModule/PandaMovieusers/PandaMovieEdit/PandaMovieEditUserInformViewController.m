
#import "PandaMovieEditUserInformViewController.h"
#import "PandaMovieEdituserInfoTableCell.h"
#import "PandaMoviewUpdateuserInfoDataModel.h"
#import "GNHGapTableViewCell.h"

@interface PandaMovieEditUserInformViewController ()

@property (nonatomic, strong) PandaMoviewUpdateuserInfoDataModel *userInformDataModel; // 更新用户消息
@property (nonatomic, strong) PandaMovieEdituserInfoTableCell *editUserInformTableViewCell;

@end

@implementation PandaMovieEditUserInformViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupDatas];
}

#pragma mark - setupDatas

- (NSArray *)autoShowSVPWithDataModel {
    return @[self.userInformDataModel];
}

- (void)setupDatas
{
    self.navigationItem.title = @"修改昵称";
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: gnh_color_a};

    // 配置数据
    GNHTableViewSectionObject *sectionObject = [[GNHTableViewSectionObject alloc] init];
    sectionObject.items = [self FilmFactroyproductSectionItems];
    sectionObject.isNeedGapTableViewCell = YES;
    
    self.sections = [@[sectionObject] mutableCopy];
    [self.tableView reloadData];
}

- (NSMutableArray *)FilmFactroyproductSectionItems
{
    NSMutableArray *items = [NSMutableArray array];

    PandaMovieEditUserInformCellItem *cellItem = [[PandaMovieEditUserInformCellItem alloc] init];
    cellItem.nickName = self.nickname;
    [items mdf_safeAddObject:cellItem];
    
    return items;
}

- (void)rightButtonAction:(UIButton *)btn
{
    NSString *nickName = [self.editUserInformTableViewCell text];
    if (!nickName.length) {
        [SVProgressHUD showWithStatus:@"请输入昵称"];
    } else {
        [self.userInformDataModel updateUserInform:nickName avatarUrl:self.anchorUrl];
    }
    self.nickname = nickName;
}

#pragma mark - setupUIs

- (void)setupUI
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setTitle:@"保存   " forState:UIControlStateNormal];
    [rightBtn setTitleColor:LGDMianColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = zy_mediumSystemFont15;
    [rightBtn addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    self.tableView.backgroundColor = gnh_color_b;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isMemberOfClass:[PandaMovieEditUserInformCellItem class]]) {
        return [PandaMovieEdituserInfoTableCell class];
    } else if ([item isMemberOfClass:[GNHFooterViewTableViewCellItem class]]) {
        return [GNHGapTableViewCell class];
    }
    
    return nil;
}

- (void)configForCell:(GNHBaseTableViewCell *)cell item:(id)item
{
    if ([item isMemberOfClass:[PandaMovieEditUserInformCellItem class]]) {
        self.editUserInformTableViewCell = (PandaMovieEdituserInfoTableCell *)cell;
    } else if ([item isMemberOfClass:[GNHFooterViewTableViewCellItem class]]) {
        GNHGapTableViewCell *gapcell = (GNHGapTableViewCell *)cell;
        gapcell.backgroundColor = gnh_color_b;
    }
}

#pragma mark - Notification

- (void)setupNotifications
{
    [super setupNotifications];
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMoviewUpdateuserInfoDataModel class]]) {
         // 修改用户信息
        [[NSNotificationCenter defaultCenter] postNotificationName:ORLoginUserInfoChangedNotification object:nil];
        [self leftButtonAction:nil];
        
        if (self.editUserInformBlock) {
            self.editUserInformBlock(self.nickname);
        }
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMoviewUpdateuserInfoDataModel class]]) {
    }
}

#pragma mark - Properties

- (PandaMoviewUpdateuserInfoDataModel *)userInformDataModel
{
    if (!_userInformDataModel) {
        _userInformDataModel = [self produceModel:[PandaMoviewUpdateuserInfoDataModel class]];
        _userInformDataModel.loadTips = @"保存中...";
    }
    return _userInformDataModel;
}


@end

