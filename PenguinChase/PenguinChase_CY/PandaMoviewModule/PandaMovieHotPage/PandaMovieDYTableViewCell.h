

#import <SJUIKit/SJUIKit.h>
#import "PandaMovieSliderView.h"
#import "PandaMovieHotChannelDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PandaMovieDYTableViewCell;

@protocol PandaMovieHotVideoControlViewDelegate <NSObject>

- (void)controlViewDidClickPriase:(PandaMovieDYTableViewCell *)controlView;

- (void)controlViewDidClickCollect:(PandaMovieDYTableViewCell *)controlView;

- (void)controlViewDidClickShare:(PandaMovieDYTableViewCell *)controlView;

- (void)controlViewDidClickPlayBtn:(PandaMovieDYTableViewCell *)controlView;

- (void)controlView:(PandaMovieDYTableViewCell *)controlView touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

@interface PandaMovieDYTableViewCell : SJBaseTableViewCell

@property (nonatomic, weak) id<PandaMovieHotVideoControlViewDelegate> delegate;

@property (nonatomic, strong) PandaMovieHotChannelDataItem  *videoItem;

@property (nonatomic, assign) BOOL isPlayButtonHidden;
@property (nonatomic, assign) BOOL isPlayButtonSelected;

- (void)setProgress:(float)progress;

- (void)startLoading;
- (void)stopLoading;

- (void)showLikeAnimation;
- (void)showUnLikeAnimation;

- (void)resumePlayStatus:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
