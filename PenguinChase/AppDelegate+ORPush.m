//
//  AppDelegate+ORPush.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/7.
//

#import "AppDelegate+ORPush.h"
#import "ORPushManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import <UMPush/UMessage.h>
#import <UMCommon/UMCommon.h>
#include <arpa/inet.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate (ORPush)
@dynamic userInfo;
@dynamic deviceToken;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - Properties

- (void)setUserInfo:(NSString *)userInfo
{
    objc_setAssociatedObject(self, @selector(setUserInfo:), userInfo, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)userInfo
{
    return objc_getAssociatedObject(self, @selector(setUserInfo:));
}

- (void)setDeviceToken:(NSString *)deviceToken
{
    objc_setAssociatedObject(self, @selector(setDeviceToken:), deviceToken, OBJC_ASSOCIATION_COPY);
}

- (NSString *)deviceToken
{
    return objc_getAssociatedObject(self, @selector(setDeviceToken:));
}

#pragma mark - Init

- (void)registPushWithConfigData:(NSDictionary *)launchOptions
{
    //设置AppKey & LaunchOptions
    [UMConfigure initWithAppkey:umengAccesskey channel:ORchannel];
    
    //开启log
    [UMConfigure setLogEnabled:YES];

    // 注册APNs - custom method - 开发者自定义的方法
    [self registerRemoteNotification:launchOptions];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    if (![deviceToken isKindOfClass:[NSData class]]) return;
    const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"deviceToken:%@",hexToken);
    
    //1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //传入的devicetoken是系统回调didRegisterForRemoteNotificationsWithDeviceToken的入参，切记
    [UMessage registerDeviceToken:deviceToken];
    
    self.deviceToken = hexToken;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

#pragma mark - 用户通知(推送) _自定义方法

/** 注册用户通知 */
- (void)registerRemoteNotification:(NSDictionary *)launchOptions
{
    // Push功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
            UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
            action1.identifier = @"action1_identifier";
            action1.title=@"打开应用";
            action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序

            UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
            action2.identifier = @"action2_identifier";
            action2.title=@"忽略";
            action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
            action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
            action2.destructive = YES;
            UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
            actionCategory1.identifier = @"category1";//这组动作的唯一标示
            [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
            NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
            entity.categories = categories;
    }
    
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];

        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories=categories;
    }
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
}

#pragma mark - 用户通知(推送)回调 _IOS 8.0以上使用

//iOS10以下使用这两个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        
        // 业务逻辑
//        [[ORPushManager sharedInstance] handleNotification:userInfo];
    }
     completionHandler(UIBackgroundFetchResultNewData);
}

//iOS10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    } else {
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
        // 业务逻辑
//        [[ORPushManager sharedInstance] handleNotification:userInfo];
    } else {
        //应用处于后台时的本地推送接受
    }
}

#pragma clang diagnostic pop

@end
