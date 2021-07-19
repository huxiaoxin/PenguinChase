

#import "GNHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PandaMovieSettingCellType) {
    ORSettingCellTypeClearMemory = 0, // 清除缓存
    ORSettingCellTypePush, // 消息推送
    ORSettingCellTypeNetwork, // 运营网络下载
    ORSettingCellTypeCheckUpgrade,  // 检查版本
    ORSettingCellTypeLogout,        // 账号注销
};

typedef void(^PandaMovieSettingActionBlock)(PandaMovieSettingCellType type, BOOL isOn);

@interface PandaMovieSettingCellItem : GNHBaseItem

@property (nonatomic, assign) PandaMovieSettingCellType cellType; // 类型
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *redirectUrl;
@property (nonatomic, assign) BOOL isOn;  // 开关是否开启

@end

@interface PandaMovieSettingTableViewCell : GNHBaseTableViewCell

@property (nonatomic, copy) PandaMovieSettingActionBlock settingActionBlock;

@end

NS_ASSUME_NONNULL_END
