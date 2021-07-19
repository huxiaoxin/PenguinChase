//
//  ORFetchSubChanelMenuDataModel.h
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/14.
//

#import "GNHBaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ORSubChannelMenuDataItem : GNHBaseItem

@property (nonatomic, copy) NSString *type; // 频道类型(切换频道时, 更换参数)
@property (nonatomic, copy) NSString *name; // 频道名称
@property (nonatomic, copy) NSString *icon; // 展示图片地址

@end

@interface ORSubChannelMenuItem : GNHRootBaseItem

@property (nonatomic, strong) NSMutableArray <__kindof ORSubChannelMenuDataItem *> *data; // 数据流

@end

@interface PandaMovieFetchSubChanelMenuDataModel : GNHBaseDataModel

@property (nonatomic, strong) ORSubChannelMenuItem *subChannelMenuItem;

/// 获取子菜单
/// @param type 一级菜单返回的type
- (BOOL)fetchChannelMenuWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
