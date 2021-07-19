

#import "GNHBaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieSearchHotKeyItem : GNHRootBaseItem
@property (nonatomic, strong) NSMutableArray *data;

@end

@interface PandaMovieSearchHotDataModel : GNHBaseDataModel
@property (nonatomic, strong) PandaMovieSearchHotKeyItem *searchHotKeyItem;

- (BOOL)PandaMoviehotKeywords;

@end

NS_ASSUME_NONNULL_END
