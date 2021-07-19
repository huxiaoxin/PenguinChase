
#import "GNHBaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieChannelMenuDataItem : GNHBaseItem

@property (nonatomic, copy) NSString *type; // 频道类型(切换频道时, 更换参数)
@property (nonatomic, copy) NSString *name; // 频道名称
@property (nonatomic, copy) NSString *icon; // 展示图片地址

@end

@interface FilmFactoryChannelMenuItem : GNHRootBaseItem

@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieChannelMenuDataItem *> *data; // 数据流

@end

@interface PandaMovieFetchChannelMenuDataModel : GNHBaseDataModel

@property (nonatomic, strong) FilmFactoryChannelMenuItem *channelMenuItem;


/// 获取首页菜单
/// @param scene 场景标识, home-首页, hotspot-热点
- (BOOL)fetchChannelMenuWithScene:(NSString *)scene;

@end

NS_ASSUME_NONNULL_END
