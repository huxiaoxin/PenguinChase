

#import "GNHBaseDataModel.h"
#import "PandaMovieVideoBaseItem.h"

@interface PandaMovieDiscoveryDataItem : PandaMovieVideoBaseItem

@end

@interface PandaMovieDiscoveryItem : GNHRootBaseItem

@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieDiscoveryDataItem *> *list; // 数据流
@end

@interface PandaMovieDiscoveryDataModel : GNHBaseDataModel
@property (nonatomic, strong) PandaMovieDiscoveryItem *discoveryItem;

- (BOOL)PandaMoviefetchDiscoverChannelWithPage:(NSInteger)page PandaMovielimit:(NSInteger)limit PandaMovieparams:(NSDictionary *)paramDic;

@end
