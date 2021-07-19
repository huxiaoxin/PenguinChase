
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieLineLoadingView : UIView

+ (void)PandaMovieshowLoadingInView:(UIView *)view withLineHeight:(CGFloat)lineHeight;

+ (void)hideLoadingInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
