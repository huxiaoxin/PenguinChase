

#import "GNHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^PandaMovieEdituserInfoBlock)(NSString *nickName);

@interface PandaMovieEditUserInformViewController : GNHBaseTableViewController
@property (nonatomic, copy) NSString *nickname;   // 昵称
@property (nonatomic, copy) NSString *anchorUrl;  // 头像地址

@property (nonatomic, copy) PandaMovieEdituserInfoBlock editUserInformBlock;

@end

NS_ASSUME_NONNULL_END
