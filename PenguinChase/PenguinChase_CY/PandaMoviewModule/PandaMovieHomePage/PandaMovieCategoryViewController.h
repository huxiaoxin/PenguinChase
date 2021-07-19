//
//  ORCategoryViewController.h
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/20.
//

#import "GNHBaseViewController.h"
#import "PandaMovieFetchChannelMenuDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ORCategoryCompleteHandel)(PandaMovieChannelMenuDataItem *item);

@interface PandaMovieCategoryViewController : GNHBaseViewController
@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieChannelMenuDataItem *> *data; // 数据流

@property (nonatomic, copy) ORCategoryCompleteHandel categoryCompleteHandel;

@end

NS_ASSUME_NONNULL_END
