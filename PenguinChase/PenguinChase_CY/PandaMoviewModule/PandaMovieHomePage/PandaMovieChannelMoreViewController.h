//
//  ORChannelMoreViewController.h
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/25.
//

#import "GNHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieChannelMoreViewController : GNHBaseTableViewController
@property (nonatomic, copy) NSString *sceneType; // 频道类型
@property (nonatomic, copy) NSString *scene;     // 子分类
@property (nonatomic, copy) NSString *sceneName; // 子分类名称

@end

NS_ASSUME_NONNULL_END
