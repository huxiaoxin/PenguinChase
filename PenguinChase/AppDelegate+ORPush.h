//
//  AppDelegate+ORPush.h
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/7.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (ORPush)

@property (nonatomic, copy) NSString *deviceToken;   // 友盟设备DeviceToken
@property (nonatomic, copy) NSDictionary *userInfo;  // 本地推送的数据

// 注册推送
- (void)registPushWithConfigData:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
