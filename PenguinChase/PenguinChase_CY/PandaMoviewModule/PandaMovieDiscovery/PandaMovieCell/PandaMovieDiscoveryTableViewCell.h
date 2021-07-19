

#import "GNHBaseTableViewCell.h"
#import "PandaMovieDiscoveryDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PandaMoVieChannelItemCallBack)(PandaMovieDiscoveryDataItem *dataItem);

@interface PandaMovieDiscoveryTableViewCell : GNHBaseTableViewCell

@property (nonatomic, copy) PandaMoVieChannelItemCallBack pandachannelItemCallBack;

@end

NS_ASSUME_NONNULL_END
