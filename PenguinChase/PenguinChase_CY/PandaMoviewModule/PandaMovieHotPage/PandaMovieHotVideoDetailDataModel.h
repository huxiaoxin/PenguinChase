

#import "GNHBaseDataModel.h"
#import "PandaMovieVideoBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieHotVideoDetailItem : GNHRootBaseItem

@property (nonatomic, copy) NSString *director;  // 导演
@property (nonatomic, copy) NSString *actor;  // 演员
@property (nonatomic, copy) NSString *areaType;  // 地区类型
@property (nonatomic, copy) NSString *areaTypeCh;  // 地区类型 中文
@property (nonatomic, copy) NSString *childType;  // 子频道分类
@property (nonatomic, copy) NSString *childTypeCh;  // 子频道分类 中文
@property (nonatomic, copy) NSString *coverImg;  // 封面图
@property (nonatomic, assign) NSInteger download; // 是否可下载 0-不可, 1-可下载 ,
@property (nonatomic, copy) NSString *episode; // 第几集
@property (nonatomic, strong) NSDictionary *episodes;  // 集数 如果有则展示 没有则不展示
@property (nonatomic, assign) NSInteger favourite;  // 是否收藏 0: 未收藏, 1-已收藏
@property (nonatomic, copy) NSString *idStr;  // 视频ID
@property (nonatomic, assign) NSInteger like;  // 是否点赞 0: 未点赞, 1-已点赞
@property (nonatomic, assign) NSInteger releaseTime;  // 发布时间
@property (nonatomic, copy) NSString *score;  // 评分
@property (nonatomic, strong) NSDictionary *source;  // 视频来源
@property (nonatomic, strong) NSMutableArray <__kindof NSDictionary *> *sourceList; // 当前视频播放源集合
@property (nonatomic, strong) NSString *videoDesc;  // 视频简介
@property (nonatomic, copy) NSString *type;  // 频道分类
@property (nonatomic, copy) NSString *typeCh;  // 频道分类 中文

@property (nonatomic, copy) NSString *videoName;  // 视频名称
@property (nonatomic, copy) NSString *videoUrl;  // 视频url 仅详情页使用
@property (nonatomic, assign) NSInteger yearType;  // 年份
@property (nonatomic, copy) NSString *yearTypeCh;  // 年份 中文

@end

@interface PandaMovieHotVideoDetailDataModel : GNHBaseDataModel
@property (nonatomic, strong) PandaMovieHotVideoDetailItem *hotVideoDetailItem;

- (BOOL)PandaMoviefetchVideoDetialWithId:(NSString *)videoId;

@end


NS_ASSUME_NONNULL_END
