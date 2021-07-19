//
//  ORKitNotificationHeader.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/11/1.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#ifndef ORKitNotificationHeader_h
#define ORKitNotificationHeader_h

// 用户强制登录
static NSString *const ORAccountForceToLoginNotification = @"AccountLoginNotification";
// 用户登录成功
static NSString *const ORAccountLoginSuccessNotification = @"AccountLoginSuccessNotification";
// 用户登录账号提示
static NSString *const ORAccountChangedNotification = @"AccountChangedNotification";
// 用户信息修改
static NSString *const ORLoginUserInfoChangedNotification = @"LoginUserInfoChangedNotification";
// 账户登出
static NSString *const ORAccountLogoutNotification = @"AccountLogoutNotification";


// webView 交互
static NSString *const kWebViewFuctionActionKey = @"WebViewFuctionActionKey"; // 交互事件

#endif /* ORKitNotificationHeader_h */
