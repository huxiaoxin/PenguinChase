

#import <UIKit/UIKit.h>
#import "PandaMovieVideoPlayerDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PandaMovieIntroCompleteBlock)(void);

@interface PandaMovieVideoIntroView : UIView

@property (nonatomic, copy) PandaMovieIntroCompleteBlock videoIntroCompleteBlock;

+ (LYCoverView *)showIntroAlertView:(PandaMovieVideoDetailItem *)detailItem completeBlock:(PandaMovieIntroCompleteBlock)completeBlock;


@end

NS_ASSUME_NONNULL_END
