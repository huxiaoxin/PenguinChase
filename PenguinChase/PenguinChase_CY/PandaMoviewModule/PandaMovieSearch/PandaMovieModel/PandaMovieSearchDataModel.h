

#import "GNHBaseDataModel.h"
#import "PandaMovieVideoBaseItem.h"

@interface PandaMovieSearchItem : GNHRootBaseItem

@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieVideoBaseItem *> *list; // 数据流
@property (nonatomic, assign) NSInteger currPage; // 当前页数
@property (nonatomic, assign) NSInteger pageSize; // 每页数据
@property (nonatomic, assign) NSInteger totalCount; // 总页数量
@property (nonatomic, assign) NSInteger totalPage; // 总页数

@end

@interface PandaMovieSearchDataModel : GNHBaseDataModel
@property (nonatomic, strong) PandaMovieSearchItem *searchItem;

- (BOOL)searchWithKeyword:(NSString *)keyword page:(NSInteger)page limit:(NSInteger)limit params:(NSDictionary *)paramDic;

@end

