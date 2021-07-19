
#import "GNHBaseDataModel.h"
#import "PandaMovieVideoBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieVideoRecommendItem : GNHRootBaseItem
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieVideoBaseItem *> *data; // 数据流

@end

@interface PandaMovieVideoRecommendDataModel : GNHBaseDataModel

@property (nonatomic, strong) PandaMovieVideoRecommendItem *videoRecommendItem;

- (BOOL)fetchRecommendVideo:(NSString *)videoId type:(NSString *)videoType;

@end

NS_ASSUME_NONNULL_END
