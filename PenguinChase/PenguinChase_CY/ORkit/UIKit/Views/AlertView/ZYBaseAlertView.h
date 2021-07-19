//
//  ZYBaseAlertView.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/12/4.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, ZYAlertViewActionType) {
    ZYAlertViewActionTypeActionTypeCancel = 0, // 取消
    ZYAlertViewActionTypeActionTypeConfirm,    // 确认
};
typedef void(^ZYAlertViewActionCallBack)(ZYAlertViewActionType type, NSString *textContent);

@interface ZYBaseAlertView : UIView

typedef void(^ZYAlertViewConfigBlock)(ZYBaseAlertView *selfView);

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) UILabel *cancelLabel;
@property (nonatomic, strong) UILabel *confirmLabel;

+ (LYCoverView *)setupViewWithCompleteBlock:(ZYAlertViewActionCallBack)completeBlock configBlock:(ZYAlertViewConfigBlock)configBlock;

@end

NS_ASSUME_NONNULL_END
