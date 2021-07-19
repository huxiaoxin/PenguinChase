
#import "GNHBaseDataModel.h"
#import "PandaMovieVideoBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieWatchRecordDataItem : GNHBaseItem

@property (nonatomic, copy) NSString *idStr;  // 视频ID
@property (nonatomic, copy) NSString *coverImg;  // 视频封面图
@property (nonatomic, copy) NSString *videoUrl;  // 播放地址
@property (nonatomic, copy) NSString *type;  // 视频类型
@property (nonatomic, copy) NSString *yearType;  // 年份
@property (nonatomic, copy) NSString *areaType;  // 地区类型
@property (nonatomic, copy) NSString *redirectLink;  // 跳转地址
@property (nonatomic, assign) NSInteger watchSeconds; // 观看时长
@property (nonatomic, copy) NSString *videoDesc;  // 视频描述
@property (nonatomic, copy) NSString *childType;  // 子频道分类
@property (nonatomic, assign) NSInteger likes;  // 点赞数
@property (nonatomic, copy) NSString *videoSeconds;  // 视频时长单位秒
@property (nonatomic, copy) NSString *videoTag;  // 视频标签(右下角: 全XX集, 更新至XX集)
@property (nonatomic, copy) NSString *episode; // 第几集
@property (nonatomic, assign) NSInteger redirectType;  // 跳转类型 0: 不跳转, 1: H5, 2: 原生界面 3:详情页 
@property (nonatomic, copy) NSString *createTime;  // 创建时间
@property (nonatomic, copy) NSString *videoName;  // 视频名称

@end

@interface PandaMovieWatchRecordItem : GNHRootBaseItem
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieWatchRecordDataItem *> *list; // 数据流
@property (nonatomic, assign) NSInteger currPage; // 当前页数
@property (nonatomic, assign) NSInteger pageSize; // 每页数据
@property (nonatomic, assign) NSInteger totalCount; // 总页数量
@property (nonatomic, assign) NSInteger totalPage; // 总页数

@end

@interface PandaMovieWatchRecordDataModel : GNHBaseDataModel
@property (nonatomic, strong) PandaMovieWatchRecordItem *watchRecordItem;

- (BOOL)fetchWatchRecordWithPage:(NSInteger)page limit:(NSInteger)limit;

@end

NS_ASSUME_NONNULL_END
