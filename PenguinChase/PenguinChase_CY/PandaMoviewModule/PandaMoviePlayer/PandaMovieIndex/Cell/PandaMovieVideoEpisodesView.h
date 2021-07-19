
#import <UIKit/UIKit.h>
#import "PandaMovieVideoPlayerDataModel.h"
#import "PandaMovieVideoBaseItem.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^PandaMovieVideoEpisodesCompleteBlock)(NSInteger index); // 第几集

@interface PandaMovieVideoEpisodesView : UIView

@property (nonatomic, copy) PandaMovieVideoEpisodesCompleteBlock videoEpisodesCompleteBlock;

+ (LYCoverView *)showIntroAlertView:(PandaMovieVideoDetailItem *)detailItem completeBlock:(PandaMovieVideoEpisodesCompleteBlock)completeBlock;

@end

NS_ASSUME_NONNULL_END
