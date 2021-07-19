

#import "GNHBaseTableViewController.h"
#import "FilmFactoryUserInformDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PandaMovieuserInfoBlock)(void);

@interface PandaMovieuserInfoController : GNHBaseTableViewController
@property (nonatomic, strong) PandaMoviewuserInfoItem *userInfoItem; // 用户信息
@property (nonatomic, copy)   PandaMovieuserInfoBlock userInformVCBlock;

@end

NS_ASSUME_NONNULL_END
