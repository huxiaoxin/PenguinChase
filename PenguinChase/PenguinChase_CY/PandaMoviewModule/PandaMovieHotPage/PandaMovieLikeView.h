

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PandaMovieLikeViewAction)(BOOL isLike);

@interface PandaMovieLikeView : UIView

@property (nonatomic, copy) PandaMovieLikeViewAction pandalikeViewAction;
@property (nonatomic, assign) BOOL isLike;

- (void)PandaMoviestartAnimationWithIsLike:(BOOL)isLike;

- (void)PandaMoviesetupLikeState:(BOOL)isLike;

- (void)PanDaMoviesetupLikeCount:(NSString *)count;

@end

NS_ASSUME_NONNULL_END
