//
//  SVProgressHUD+ZY.h
//  ZhangYuSports
//
//  Created by 似水灵修 on 2020/4/19.
//  Copyright © 2020 ChenYuan. All rights reserved.
//

#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (ZY)

+ (void)config;

+ (void)showLoading:(NSString *)msg;
+ (void)showSuccess:(NSString *)msg completion:(nullable void(^)(void))completion;
+ (void)showInfo:(NSString *)msg completion:(nullable void(^)(void))completion;
+ (void)showError:(NSString *)msg completion:(nullable void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
