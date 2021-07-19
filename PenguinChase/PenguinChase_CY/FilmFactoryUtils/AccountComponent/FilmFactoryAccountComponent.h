
#import "ORSingleton.h"


@interface FilmFactoryBriefMemberItem : GNHBaseItem

@property (nonatomic, assign) NSUInteger uid;    // 用户ID
@property (nonatomic, copy) NSString *nickName;  // 昵称
@property (nonatomic, copy) NSString *portraitUrl;  // 头像地址

@end

@interface FilmFactoryAccountComponent : ORSingleton

// 用户token
@property (nonatomic, strong, readonly, getter=fetchAccesstoken) NSString *accesstoken;

// 用户ID
@property (nonatomic, assign, readonly, getter=fetchUserID) NSUInteger uid;

// 用户昵称
@property (nonatomic, copy, readonly, getter=fetchNickName) NSString *nickName;

// 头像地址
@property (nonatomic, copy, readonly, getter=fetchPortraitUrl) NSString *portraitUrl;

// 用户账号
@property (nonatomic, copy, readonly, getter=fetchAccountNumber) NSString *accountNum;

// 存储用户最后一次登录账号
- (void)storeLastLoginAccount:(NSString *)account;

// 存储Token
- (void)storeAccessToken:(NSString *)token;

// 存储用户信息
- (void)storeUserItem:(FilmFactoryBriefMemberItem *)loginUserInfo;

// 退出登录
- (void)logout;

#pragma mark - Class Method

// 检查用户登录
+ (BOOL)checkLogin:(BOOL)gotoLogin;

@end
