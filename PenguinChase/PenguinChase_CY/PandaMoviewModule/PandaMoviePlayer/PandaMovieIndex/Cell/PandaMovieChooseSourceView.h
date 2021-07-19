
#import <UIKit/UIKit.h>
#import "PandaMovieVideoPlayerDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PandaMovieChooseSourceCompleteBlock)(NSString *sourceName);

@interface PandaMovieChooseSourceView : UIView

@property (nonatomic, copy) PandaMovieChooseSourceCompleteBlock chooseSourceCompleteBlock;

- (instancetype)PandaMovieinitWithFrame:(CGRect)frame sources:(NSMutableArray <__kindof PandaMovieVideoSourceItem *> *)sources selectSource:(NSString *)selectSourceName;

@end

NS_ASSUME_NONNULL_END
