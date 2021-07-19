
#import "ORSingleton.h"
#import "PandaMovieWatchRecordDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilmFacotryVideoModel : PandaMovieWatchRecordDataItem
@end

@interface FilmFacotryVideoReportManager : ORSingleton
@property (nonatomic, strong) NSMutableArray <__kindof FilmFacotryVideoModel *> *videoItems;

// 存储视频信息
- (void)restoreVideoHistory:(FilmFacotryVideoModel *)videoItem;
- (void)deleteVideoHistorey:(NSArray *)videos;

- (BOOL)videoReportWithData:(NSString *)type videoId:(NSString *)videoId watchSeconds:(NSInteger)watchSeconds;

@end

NS_ASSUME_NONNULL_END
