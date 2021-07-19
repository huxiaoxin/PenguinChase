//
//  SVProgressHUD+ZY.m
//  ZhangYuSports
//
//  Created by 似水灵修 on 2020/4/19.
//  Copyright © 2020 ChenYuan. All rights reserved.
//

#import "SVProgressHUD+ZY.h"

@implementation SVProgressHUD (ZY)

+ (void)config {
    // SVProgress 样式
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMaximumDismissTimeInterval:1.0f];
    [SVProgressHUD setMinimumSize:CGSizeMake(120, 120)];
    [SVProgressHUD setCornerRadius:4];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"hud_success"]];
}

+ (void)showLoading:(NSString *)msg {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setMinimumSize:CGSizeMake(120, 120)];
    [self showWithStatus:msg];
}

+ (void)showSuccess:(NSString *)msg completion:(void (^)(void))completion {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumSize:CGSizeMake(120, 120)];
    [self showSuccessWithStatus:msg];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

+ (void)showInfo:(NSString *)msg completion:(void (^)(void))completion {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumSize:CGSizeMake(120, 36)];
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@""]];
    [self showInfoWithStatus:msg];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

+ (void)showError:(NSString *)msg completion:(void (^)(void))completion {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumSize:CGSizeMake(120, 120)];
    [self showErrorWithStatus:msg];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

@end
