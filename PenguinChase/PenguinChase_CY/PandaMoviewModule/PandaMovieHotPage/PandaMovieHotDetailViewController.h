
#import "GNHBaseViewController.h"
#import "PandaMovieHotVideoView.h"
#import "PandaMovieHotChannelDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PandaMovieHotDetailViewController;

@interface PandaMovieHotDetailViewController : GNHBaseViewController

@property (nonatomic, strong) PandaMovieHotVideoView *videoView;

// 播放单个视频
- (instancetype)initWithVideoModel:(PandaMovieHotChannelDataItem *)videoItem;

// 播放一组视频，并指定播放位置
- (instancetype)initWithVideos:(NSArray *)videos index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
