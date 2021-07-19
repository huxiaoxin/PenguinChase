
#import "GNHBaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieDiscoveryTypeItem : GNHBaseItem

@property (nonatomic, copy) NSString *name; // 频道名称
@property (nonatomic, copy) NSString *type; // 频道类型(切换频道时, 更换参数)
@property (nonatomic, copy) NSString *icon; // 图标

@end

@interface PandaMovieDiscoveryMenuItem : GNHRootBaseItem
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieDiscoveryTypeItem *> *channelTypes; // 视频分类类型 ,
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieDiscoveryTypeItem *> *areaTypes; // 地区 选项类型
@property (nonatomic, strong) NSDictionary *types; // 子分类
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieDiscoveryTypeItem *> *yearTypes; // 年份选项类型

@end

@interface PandaMovieDiscoveryMenuDataModel : GNHBaseDataModel
@property (nonatomic, strong) PandaMovieDiscoveryMenuItem *discoveryMenuItem;

- (BOOL)PandaMoviefetchDiscoveryMenu:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
