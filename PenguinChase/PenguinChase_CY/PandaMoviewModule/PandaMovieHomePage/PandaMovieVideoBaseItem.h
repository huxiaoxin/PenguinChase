

#import "GNHBaseItem.h"
#import <YYModel/NSObject+YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieVideoBaseItem : GNHBaseItem

@property (nonatomic, copy) NSString *coverImg;  // 视频封面图
@property (nonatomic, copy) NSString *createTime;  // 创建时间
@property (nonatomic, copy) NSString *episode; // 第几集
@property (nonatomic, copy) NSString *idStr;  // 视频ID
@property (nonatomic, assign) NSInteger likes;  // 点赞数
@property (nonatomic, copy) NSString *redirectLink;  // 跳转地址
@property (nonatomic, assign) NSInteger redirectType;  // 跳转类型 0: 不跳转, 1: H5, 2: 原生界面 3:详情页

@property (nonatomic, copy) NSString *type;  // 视频类型
@property (nonatomic, copy) NSString *typeCh;  // 视频类型中文
@property (nonatomic, copy) NSString *videoDesc;  // 视频描述
@property (nonatomic, copy) NSString *score;  // 评分
@property (nonatomic, copy) NSString *videoName;  // 视频名称
@property (nonatomic, copy) NSString *videoSeconds;  // 视频时长单位秒
@property (nonatomic, copy) NSString *videoTag;  // 视频标签(右下角: 全XX集, 更新至XX集)
@property (nonatomic, copy) NSString *videoUrl;  // 播放地址
@property (nonatomic, copy) NSString *areaType;  // 地区类型
@property (nonatomic, copy) NSString *areaTypeCh;  // 地区类型 中文
@property (nonatomic, copy) NSString *childType;  // 子频道分类
@property (nonatomic, copy) NSString *childTypeCh;  // 子频道分类 中文
@property (nonatomic, copy) NSString *yearType;  // 年份
@property (nonatomic, copy) NSString *yearTypeCh;  // 年份中文

@property (nonatomic, copy) NSString *actor;  // 演员
@property (nonatomic, copy) NSString *director;  // 导演

@end

NS_ASSUME_NONNULL_END
