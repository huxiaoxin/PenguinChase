
#import "GNHBaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FilmFactoryAQUpgradeType) {
    AQUpgradeTypeForce = 0,  // 强制升级
    AQUpgradeTypeRemind,     // 提醒
    AQUpgradeTypeUnUpgrade,  // 不升级
};

@interface FilmFactoryUpgradeItem : GNHRootBaseItem

@property (nonatomic, copy) NSString *content;  // 内容标题
@property (nonatomic, copy) NSString *downloadUrl;  // 下载地址
@property (nonatomic, copy) NSString *platform;  // app来源 iOS Android
@property (nonatomic, copy) NSString *remark;  // 操作说明
@property (nonatomic, copy) NSString *title;  // 标题
@property (nonatomic, assign) FilmFactoryAQUpgradeType upgradeType; // 升级类型: 0:强制 1:提示 2:不升级
@property (nonatomic, copy) NSString *versionCode;  // 版本（Android使用 200）

@end

@interface FilmFactoryUpgeDataModel : GNHBaseDataModel
@property (nonatomic, strong) FilmFactoryUpgradeItem *upgradeItem;

- (BOOL)fetchUpgradeInfo;

@end

NS_ASSUME_NONNULL_END
