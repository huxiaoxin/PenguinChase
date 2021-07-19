
#import "FilmFactoryUpgradeManager.h"
#import "FilmFactoryUpgradeView.h"
#import "FilmFactoryUpgeDataModel.h"

@interface FilmFactoryUpgradeManager ()

@property (nonatomic, copy) NSString *version;

@property (nonatomic, weak) LYCoverView *updateBgView;
@property (nonatomic, strong) FilmFactoryUpgeDataModel *upgradeDataModel;

@end

@implementation FilmFactoryUpgradeManager

#pragma mark - LifeCycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDatas];
    }
    return self;
}

#pragma mark - SetupData

- (void)setupDatas
{
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    self.version = dict[@"CFBundleShortVersionString"];
    
    [self.upgradeDataModel fetchUpgradeInfo];
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    GNHWeakSelf;
    if ([gnhModel isMemberOfClass:[FilmFactoryUpgeDataModel class]]) {
        if (!weakSelf.updateBgView) {
            FilmFactoryUpgradeItem *checkViewItem = self.upgradeDataModel.upgradeItem;
            
            if ([self.version compare:checkViewItem.versionCode options:NSNumericSearch] == NSOrderedAscending) {
                // 小于 version 的版本
                if (checkViewItem.upgradeType == AQUpgradeTypeForce) {
                    // 强制升级
                    self.updateBgView = [FilmFactoryUpgradeView setupView:checkViewItem.content upgradeUrl:checkViewItem.downloadUrl  version:checkViewItem.versionCode isForceUpgrade:YES];
                } else if (checkViewItem.upgradeType == AQUpgradeTypeRemind) {
                    // 普通升级
                    self.updateBgView = [FilmFactoryUpgradeView setupView:checkViewItem.content upgradeUrl:checkViewItem.downloadUrl  version:checkViewItem.versionCode isForceUpgrade:NO];
                }
            }
        }
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    if ([gnhModel isMemberOfClass:[FilmFactoryUpgeDataModel class]]) {
        
    }
}

#pragma mark - Properties

- (FilmFactoryUpgeDataModel *)upgradeDataModel
{
    if (!_upgradeDataModel) {
        _upgradeDataModel = [self produceModel:[FilmFactoryUpgeDataModel class]];
    }
    return _upgradeDataModel;
}

@end
