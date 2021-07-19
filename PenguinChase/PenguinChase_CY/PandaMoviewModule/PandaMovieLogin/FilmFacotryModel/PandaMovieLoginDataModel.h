
#import "GNHBaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PandaMovieLoginItem : GNHRootBaseItem

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *avatarUrl;

@end

@interface PandaMovieLoginDataModel : GNHBaseDataModel

@property (nonatomic, strong) PandaMovieLoginItem *loginItem;

/// 登录
/// @param phone 手机
/// @param code 验证码
- (BOOL)loginAccount:(NSString *)phone code:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
