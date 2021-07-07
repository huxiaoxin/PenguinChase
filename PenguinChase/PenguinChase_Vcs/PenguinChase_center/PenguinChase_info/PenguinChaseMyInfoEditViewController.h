

#import "PenguinChaseListViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^PenguinChaseSeltecdInfo)(void);
@interface PenguinChaseMyInfoEditViewController : PenguinChaseListViewController
@property(nonatomic,copy) PenguinChaseSeltecdInfo  seltecdInfoBlock;
@end

NS_ASSUME_NONNULL_END
