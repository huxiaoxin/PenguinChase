
#import <UIKit/UIKit.h>
#import "PandaMovieHotChannelDataModel.h"
#import "PandaMovieHotVideoDetailDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PandaMovieHotVideoView;

@protocol PandaMovieHotVideoViewDelegate <NSObject>

@optional

- (void)videoView:(PandaMovieHotVideoView *)videoView didClickPraise:(PandaMovieHotChannelDataItem *)videoModel;
- (void)videoView:(PandaMovieHotVideoView *)videoView didClickShare:(PandaMovieHotChannelDataItem *)videoModel;
- (void)videoView:(PandaMovieHotVideoView *)videoView didClickCollect:(PandaMovieHotChannelDataItem *)videoModel;
- (void)videoView:(PandaMovieHotVideoView *)videoView didPanWithDistance:(CGFloat)distance isEnd:(BOOL)isEnd;

@end

typedef void(^PandaMovieUpdateVideoDetailCompleteBlock)(NSString *videoId);

@interface PandaMovieHotVideoView : UIView

@property (nonatomic, copy) PandaMovieUpdateVideoDetailCompleteBlock updateVideoDetailCompleteBlock;

@property (nonatomic, weak) id<PandaMovieHotVideoViewDelegate>   delegate;

@property (nonatomic, assign) NSString *videotype; // 视频类型

// 多条数据
- (void)setModels:(NSArray *)models index:(NSInteger)index;
- (void)setModels:(NSArray *)models index:(NSInteger)index canRefresh:(BOOL)canRefresh;

// 刷新UI
- (void)refreshUI:(PandaMovieHotVideoDetailItem *)videoDetailItem;

// 收藏
- (void)favorite:(NSString *)videoId actionType:(NSInteger)action; // 0-取消收藏；1-收藏

// 点赞
- (void)praise:(NSString *)videoId actionType:(NSInteger)action; // 0-取消点赞；1-点赞

#pragma mark - class method

- (void)vc_viewDidAppear;
- (void)vc_viewWillDisappear;
- (void)vc_viewDidDisappear;

@end

NS_ASSUME_NONNULL_END
