//
//  ORHotChannelTableViewCell.h
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/22.
//

#import "GNHBaseTableViewCell.h"
#import "PandaMovieHotChannelDataModel.h"
//
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ORHotChannelActionType) {
    ORHotChannelActionTypePlay = 0,  // 播放
    ORHotChannelActionTypeShare,     // 分享
    ORHotChannelActionTypeLike,      // 点赞
    ORHotChannelActionTypeMore,      // 更多
};

typedef void(^ORHotChannelActionBlock)(PandaMovieHotChannelDataItem *dataItem, ORHotChannelActionType type);

@interface ORHotChannelTableViewCell : GNHBaseTableViewCell

@property (nonatomic, copy) ORHotChannelActionBlock hotChannelActionBlock;

@end

NS_ASSUME_NONNULL_END
