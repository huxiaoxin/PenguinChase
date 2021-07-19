
#import "GNHBaseItem.h"
#import "PandaMovieVideoBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieIndexChannelItem : GNHRootBaseItem
@property (nonatomic, assign) NSInteger currPage; // 当前页数
@property (nonatomic, assign) NSInteger pageSize; // 每页数据
@property (nonatomic, assign) NSInteger totalCount; // 总页数量
@property (nonatomic, assign) NSInteger totalPage; // 总页数
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieVideoBaseItem *> *list; // 数据流

@end

NS_ASSUME_NONNULL_END
