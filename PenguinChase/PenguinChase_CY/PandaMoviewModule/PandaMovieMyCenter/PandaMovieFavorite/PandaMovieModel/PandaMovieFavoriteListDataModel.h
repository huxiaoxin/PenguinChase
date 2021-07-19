

#import "GNHBaseDataModel.h"
#import "PandaMovieVideoBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieFavoriteListDataItem : PandaMovieVideoBaseItem

@end

@interface PandaMovieFavoriteListItem : GNHRootBaseItem
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieFavoriteListDataItem *> *list; // 数据流
@property (nonatomic, assign) NSInteger currPage; // 当前页数
@property (nonatomic, assign) NSInteger pageSize; // 每页数据
@property (nonatomic, assign) NSInteger totalCount; // 总页数量
@property (nonatomic, assign) NSInteger totalPage; // 总页数

@end

@interface PandaMovieFavoriteListDataModel : GNHBaseDataModel
@property (nonatomic, strong) PandaMovieFavoriteListItem *favoriteListItem;

- (BOOL)fetchFavoriteWithPage:(NSInteger)page limit:(NSInteger)limit;

@end

NS_ASSUME_NONNULL_END
