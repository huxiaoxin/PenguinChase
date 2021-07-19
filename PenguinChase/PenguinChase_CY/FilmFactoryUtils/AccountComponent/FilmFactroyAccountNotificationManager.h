

#import "ORSingleton.h"

@protocol FilmFactoryAccountObserver <NSObject>

@optional

// 当前登录的用户信息发生改变
- (void)handleLoginUserInfoChanged;

// accessToken失效
- (void)handleAccessTokenInvalidated:(NSNumber *)returnCode;

// 账号切换
- (void)handleAccountChanged:(NSDictionary *)userInfo;

// 账号登出
- (void)handleAccountLogout:(NSDictionary *)userInfo;

// 账号登录
- (void)handleAccountLogin:(NSDictionary *)userInfo;

@end

@interface FilmFactroyAccountNotificationManager : ORSingleton


// 注册
- (void)registerObserver:(NSObject<FilmFactoryAccountObserver> *)observer;

// 移除注册
- (void)removeObserver:(NSObject<FilmFactoryAccountObserver> *)observer;

@end
