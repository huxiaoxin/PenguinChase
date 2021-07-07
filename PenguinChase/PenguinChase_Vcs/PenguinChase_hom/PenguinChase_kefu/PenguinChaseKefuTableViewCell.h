#import <UIKit/UIKit.h>
#import "PenguinChaseKefuModel.h"
#import "PenguinChaseMessageDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseKefuTableViewCell : UITableViewCell
@property(nonatomic,strong) PenguinChaseKefuModel * penguinModel;
@property(nonatomic,strong) PenguinChaseMessageDetailModel * penguinDetailModel;
@end

NS_ASSUME_NONNULL_END
