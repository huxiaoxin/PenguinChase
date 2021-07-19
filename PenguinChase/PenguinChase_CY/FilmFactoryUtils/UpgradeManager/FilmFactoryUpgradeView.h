

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilmFactoryUpgradeView : UIView

+ (LYCoverView *)setupView:(NSString *)upgradeContent upgradeUrl:(NSString *)upgradeUrl version:(NSString *)version isForceUpgrade:(BOOL)isforceUpgrade;

@end

NS_ASSUME_NONNULL_END
