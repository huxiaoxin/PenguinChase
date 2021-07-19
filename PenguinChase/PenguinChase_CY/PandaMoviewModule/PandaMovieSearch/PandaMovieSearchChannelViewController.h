
#import "GNHBaseTableViewController.h"
#import "PandaMovieSearchDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PandaMovieSearchChannelCompleteBlock)(void);

@interface PandaMovieSearchChannelViewController : GNHBaseTableViewController
@property (nonatomic, copy) NSString *typeId; // 分类
@property (nonatomic, copy) NSString *keyword; // 关键词

@property (nonatomic, copy) PandaMovieSearchChannelCompleteBlock searchChannelCompleteBlock;

@end

NS_ASSUME_NONNULL_END
