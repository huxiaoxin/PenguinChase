//
//  ORChannelTableViewCell.h
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/21.
//

#import "GNHBaseTableViewCell.h"
#import "PandaMoVieChannelSenceDataModel.h"


typedef void(^ORChannelItemCallBack)(PandaMovieVideoBaseItem *dataItem, NSString *sence, NSString *sceneName, NSInteger type);  // 0、详情；1、更多
typedef void(^ORRefreshDataCallback)(NSString *scene, NSInteger indexRow);

@interface PandaMovieChannelTableViewCell : GNHBaseTableViewCell

@property (nonatomic, copy) ORChannelItemCallBack channelItemCallBack;
@property (nonatomic, copy) ORRefreshDataCallback refreshDataCallback;

@end
