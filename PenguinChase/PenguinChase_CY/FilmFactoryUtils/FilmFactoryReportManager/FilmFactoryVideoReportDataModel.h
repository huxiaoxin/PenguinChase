

#import "GNHBaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilmFactoryVideoReportDataModel : GNHBaseDataModel

- (BOOL)videoReportWithData:(NSString *)videoId type:(NSString *)type time:(NSInteger)watchSeconds;

@end

NS_ASSUME_NONNULL_END
