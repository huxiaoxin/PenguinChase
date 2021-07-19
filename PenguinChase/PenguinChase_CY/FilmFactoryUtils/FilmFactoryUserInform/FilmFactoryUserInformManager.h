
#import "ORSingleton.h"
#import "FilmFactoryUserInformDataModel.h"

typedef void(^ORUpdateUserInfoCompleteHandle)(BOOL success, PandaMoviewuserInfoItem *userInfo);

@interface FilmFactoryUserInformManager : ORSingleton

- (PandaMoviewuserInfoItem *)fetchUserInfo;

- (BOOL)updateUserInfo:(ORUpdateUserInfoCompleteHandle)completeBlock;

- (void)autoLogin;

@end
