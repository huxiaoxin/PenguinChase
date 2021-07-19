//
//  ORChannelMoreTableViewCell.h
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/25.
//

#import "GNHBaseTableViewCell.h"
#import "PandaMovieIndexChannelItem.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ORChannelItemCallBack)(PandaMovieVideoBaseItem *dataItem); // 0-详情

@interface ORChannelMoreTableViewCell : GNHBaseTableViewCell
@property (nonatomic, copy) ORChannelItemCallBack channelItemCallBack;

@end

NS_ASSUME_NONNULL_END
