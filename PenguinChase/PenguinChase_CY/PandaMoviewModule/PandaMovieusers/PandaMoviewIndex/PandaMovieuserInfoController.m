

#import "PandaMovieuserInfoController.h"
#import "PandaMovieEditUserInformViewController.h"
#import "PandaMoviewuserInfoTableViewCell.h"
#import "GNHGapTableViewCell.h"
#import "ORImagePickManager.h"
#import "ORUploadFileManager.h"
#import "FilmFactoryUserInformManager.h"
#import "PandaMoviewUpdateuserInfoDataModel.h"
@interface PandaMovieuserInfoController ()
@property (nonatomic, strong) PandaMoviewUpdateuserInfoDataModel *userInformDataModel; // 更新用户消息
@property (nonatomic, strong) ZYFormData *formImageData;
@end

@implementation PandaMovieuserInfoController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self PandaMoviewSetupUI];
    
    [self PandaMoviewSetupDatas];
}

#pragma mark - PandaMoviewSetupDatas

- (void)PandaMoviewSetupDatas
{
    self.navigationItem.title = @"编辑资料";
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: gnh_color_a};

    [self PandaMoviewConfigerSectionData];
    
    GNHWeakSelf;
    self.userInformVCBlock = ^{
        [weakSelf.tableView reloadData];
    };
}

- (void)PandaMoviewConfigerSectionData
{
    // 配置数据
    GNHTableViewSectionObject *pandaObject1 = [[GNHTableViewSectionObject alloc] init];
    pandaObject1.didSelectSelector = NSStringFromSelector(@selector(selectCellWithItem:indexPath:));
    pandaObject1.items = [self FilmFactroyproductSectionItems:0];
    pandaObject1.gapTableViewCellHeight = 9.0f;
    pandaObject1.isNeedGapTableViewCell = YES;
    pandaObject1.footerTableViewCellHeight = 0;

    GNHTableViewSectionObject *pandaObject2 = [[GNHTableViewSectionObject alloc] init];
    pandaObject2.didSelectSelector = NSStringFromSelector(@selector(selectCellWithItem:indexPath:));
    pandaObject2.items = [self FilmFactroyproductSectionItems:1];
    pandaObject2.gapTableViewCellHeight = 9.0f;
    pandaObject2.isNeedGapTableViewCell = YES;
    pandaObject2.footerTableViewCellHeight = 0;
    self.sections = [@[pandaObject1, pandaObject2] mutableCopy];
    [self.tableView reloadData];
}

- (NSMutableArray *)FilmFactroyproductSectionItems:(NSInteger)sectionType
{
    NSMutableArray *items = [NSMutableArray array];

    if (sectionType == 0) {
        PandaMoviewuserinfoCellitem *portraitItem = [[PandaMoviewuserinfoCellitem alloc] init];
        portraitItem.title = @"头像";
        portraitItem.anchorUrl = self.userInfoItem.avatar;
        portraitItem.cellType = PandaMoviewCellTypePortrail;
        [items mdf_safeAddObject:portraitItem];
        
        PandaMoviewuserinfoCellitem *nickNameItem = [[PandaMoviewuserinfoCellitem alloc] init];
        nickNameItem.title = @"昵称";
        nickNameItem.content = self.userInfoItem.username;
        nickNameItem.cellType = PandaMoviewCellTypeNickName;
        [items mdf_safeAddObject:nickNameItem];
    }
    
    return items;
}

#pragma mark - PandaMoviewSetupUIs

- (void)PandaMoviewSetupUI
{
    self.tableView.backgroundColor = gnh_color_com;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isMemberOfClass:[PandaMoviewuserinfoCellitem class]]) {
        return [PandaMoviewuserInfoTableViewCell class];
    } else if ([item isMemberOfClass:[GNHFooterViewTableViewCellItem class]]) {
        return [GNHGapTableViewCell class];
    }
    
    return nil;
}

#pragma mark - Notification

- (void)setupNotifications
{
    [super setupNotifications];
}

#pragma mark PandaMoviewSetupDatas

- (void)uploadProtrait
{
    GNHWeakSelf;
    [[ORUploadFileManager sharedInstance] uploadImageManager:self.formImageData completeHandler:^(BOOL isSuccess, NSString *url) {
        if (isSuccess) {
            weakSelf.formImageData = nil;
            [weakSelf.userInformDataModel updateUserInform:weakSelf.userInfoItem.username avatarUrl:url];
        }
    } uploadType:@"AVATAR"];
}

#pragma mark - UITableview Delegate

- (void)selectCellWithItem:(id<GNHBaseActionItemProtocol>)item indexPath:(NSIndexPath *)indexPath
{
    if ([item isMemberOfClass:[PandaMoviewuserinfoCellitem class]]) {
        GNHWeakSelf;
        PandaMoviewuserinfoCellitem *cellItem = (PandaMoviewuserinfoCellitem *)item;
        GNHWeakObj(cellItem);
        switch (cellItem.cellType) {
            case PandaMoviewCellTypePortrail: { // 头像
                [[ORImagePickManager sharedInstance] pickCircleImage:^(UIImage *image, ZYFormData *imageData) {
                    if (image && imageData) {
                        weakSelf.formImageData = imageData;
                        weakcellItem.image = image;
                        
                        // 上传头像
                        [weakSelf uploadProtrait];
                        
                        [weakSelf.tableView reloadData];
                        
                        [[UIViewController mdf_toppestViewController] dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
                break;
            }
            case PandaMoviewCellTypeNickName: { // 昵称
                PandaMovieEditUserInformViewController *editUserInformVC = [[PandaMovieEditUserInformViewController alloc] init];
                editUserInformVC.nickname = weakSelf.userInfoItem.username;
                editUserInformVC.anchorUrl = weakSelf.userInfoItem.avatar;
                [self.navigationController pushViewController:editUserInformVC animated:YES];
                
                GNHWeakSelf;
                editUserInformVC.editUserInformBlock = ^(NSString * _Nonnull nickName) {
                    weakSelf.userInfoItem.username = nickName;
                    GNHTableViewSectionObject *sectionOject = weakSelf.sections.firstObject;
                    [sectionOject.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass:[PandaMoviewuserinfoCellitem class]]) {
                            PandaMoviewuserinfoCellitem *userInformCellItem = (PandaMoviewuserinfoCellitem *)obj;
                            if (userInformCellItem.cellType == PandaMoviewCellTypeNickName) {
                                userInformCellItem.content = nickName;

                                [weakSelf.tableView reloadData];

                                *stop = YES;
                            }
                        }
                    }];
                };
                
                break;
            }
            default:
                break;
        }
    };
}

- (BOOL)checkBundleMobile:(NSString *)mobile tips:(NSString *)tips
{
    if (mobile.length) {
        return YES;
    } else {
        [SVProgressHUD showInfoWithStatus:tips];
        
        return NO;
    }
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMoviewUpdateuserInfoDataModel class]]) {
         // 修改用户信息
        [[NSNotificationCenter defaultCenter] postNotificationName:ORLoginUserInfoChangedNotification object:nil];
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
    }
    return _userInformDataModel;
}


@end
