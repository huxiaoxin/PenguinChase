

#import "GNHBaseTableViewCell.h"
#import "PandaMovieVideoBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PandaMovieRecommendItemCallBack)(PandaMovieVideoBaseItem *dataItem);

@interface PandaMovieVideoRecommendTableViewCell : GNHBaseTableViewCell

@property (nonatomic, copy) PandaMovieRecommendItemCallBack recommendItemCallBack;

@end

NS_ASSUME_NONNULL_END
