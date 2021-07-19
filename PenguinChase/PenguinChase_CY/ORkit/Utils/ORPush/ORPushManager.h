//
//  ORPushManager.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2019/2/17.
//  Copyright © 2019 ChenYuan. All rights reserved.
//

#import "ORSingleton.h"
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface ORPushManager : ORSingleton

@property (nonatomic, copy) NSString *pushClientId;  // 推送pushID

- (void)handleNotification:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
