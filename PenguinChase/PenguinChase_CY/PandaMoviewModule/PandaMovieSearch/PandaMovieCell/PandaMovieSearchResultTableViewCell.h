

#import "GNHBaseTableViewCell.h"
#import "PandaMovieVideoBaseItem.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^PandaMovieChannelItemCallBack)(PandaMovieVideoBaseItem *dataItem, NSInteger type);

@interface PandaMovieSearchResultTableViewCell : GNHBaseTableViewCell
@property (nonatomic, copy) PandaMovieChannelItemCallBack filmfactoychannelItemCallBack;

@end

NS_ASSUME_NONNULL_END
