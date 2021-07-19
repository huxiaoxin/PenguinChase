//
//  ORFetchBannerDataModel.h
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/20.
//

#import "GNHBaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BannerRedirectType) {
    BannerRedirectTypeUnknow = 0,  // 不跳转
    BannerRedirectTypeH5, // H5
    BannerRedirectTypeNative, // 原生页面
    BannerRedirectTypeVideoDetail, // 影视详情
};

@interface ORBannerDataItem : GNHBaseItem

@property (nonatomic, copy) NSString *desc;  // banner描述
@property (nonatomic, copy) NSString *image;  // banner图片
@property (nonatomic, assign) NSInteger order;  // 权重
@property (nonatomic, copy) NSString *redirectLink;  // 跳转地址
@property (nonatomic, assign) NSInteger redirectType;  // 跳转类型 0: 不跳转, 1: H5, 2: 原生界面 3:详情页
@property (nonatomic, copy) NSString *videoType;  // 视频类型

@end

@interface ORBannerItem : GNHRootBaseItem
@property (nonatomic, strong) NSMutableArray <__kindof ORBannerDataItem *> *data; // 数据流

@end

@interface PandaMovieBannerDataModel : GNHBaseDataModel
@property (nonatomic, strong) ORBannerItem *bannerItem;

- (BOOL)fetchBannerWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
