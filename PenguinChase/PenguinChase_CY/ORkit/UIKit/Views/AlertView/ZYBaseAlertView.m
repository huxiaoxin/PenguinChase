//
//  ZYBaseAlertView.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/12/4.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "ZYBaseAlertView.h"
#import <objc/runtime.h>
@interface ZYBaseAlertView ()<UITextFieldDelegate>

@property (nonatomic, copy) dispatch_block_t cancelCallBack;
@property (nonatomic, strong) UIView *groundView;

@end

@implementation ZYBaseAlertView

#pragma mark - Class Method

+ (LYCoverView *)setupViewWithCompleteBlock:(ZYAlertViewActionCallBack)completeBlock configBlock:(nonnull ZYAlertViewConfigBlock)configBlock
{
    LYCoverView *backView = [LYCoverView showView:nil inView:[self appWindow]];
    backView.touchDisMiss = NO;
    
    ZYBaseAlertView *alertView = [[ZYBaseAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) completeBlock:completeBlock];
    [backView addSubview:alertView];
    
    GNHWeakObj(alertView);
    if (configBlock) {
        configBlock(weakalertView);
    }
    
    GNHWeakObj(backView);
    alertView.cancelCallBack = ^{
        [weakbackView disMiss];
    };
    
    return backView;
}

/** 获取当前Window */
+ (UIWindow *)appWindow
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //app Window的windowLevel默认是UIWindowLevelNormal
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame completeBlock:(ZYAlertViewActionCallBack)completeBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupViewsWithCompleteBlock:completeBlock];
    }
    return self;
}

- (instancetype)initViewWithCompleteBlock:(ZYAlertViewActionCallBack)completeBlock
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupViewsWithCompleteBlock:completeBlock];
    }
    return self;
}

- (void)setupViewsWithCompleteBlock:(ZYAlertViewActionCallBack)completeBlock
{
    GNHWeakSelf;
    
    UIView *groundView = [[UIView alloc] init];
    groundView.backgroundColor = gnh_color_b;
    groundView.layer.cornerRadius = 6.0f;
    groundView.layer.masksToBounds = YES;
    [self addSubview:groundView];
    [groundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(258.0f);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(287.0f, 151.0f));
    }];
    self.groundView = groundView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"当前部落需要申请才能加入";
    titleLabel.textColor = gnh_color_a;
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [groundView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(groundView.mas_top).offset(19.0f);
        make.centerX.mas_equalTo(groundView.mas_centerX);
        make.height.mas_equalTo(20.0f);
    }];
    self.titleLabel = titleLabel;
    
    UITextField *contentTextField = [[UITextField alloc] init];
    contentTextField.placeholder = @"介绍一下自己吧～";
//    [contentTextField setValue:gnh_color_e forKeyPath:@"_placeholderLabel.textColor"];
    //iOS 13 私有方法禁用后修改
    Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(contentTextField, ivar);
    placeholderLabel.textColor = gnh_color_e;


    
    contentTextField.textColor = gnh_color_a;
    contentTextField.font = [UIFont systemFontOfSize:12.0f];
    contentTextField.textAlignment = NSTextAlignmentLeft;
    contentTextField.returnKeyType = UIReturnKeyDone;
    contentTextField.delegate = self;
    [groundView addSubview:contentTextField];
    self.contentTextField = contentTextField;
    [contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(18.0f);
        make.left.mas_equalTo(groundView.mas_left).offset(48.0f);
        make.size.mas_equalTo(CGSizeMake(215.0f, 25.0f));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = gnh_color_m;
    [groundView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentTextField.mas_bottom).offset(2.0f);
        make.left.mas_equalTo(groundView.mas_left).offset(35.0f);
        make.right.mas_equalTo(groundView.mas_right).offset(-35.0f);
        make.height.mas_equalTo(1.0f);
    }];
    
    UIView *verlineView = [[UIView alloc] init];
    verlineView.backgroundColor = gnh_color_n;
    [groundView addSubview:verlineView];
    [verlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(17.0f);
        make.centerX.mas_equalTo(groundView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(1.0f, 28.0f));
    }];
    
    UILabel *cancelLabel = [[UILabel alloc] init];
    cancelLabel.backgroundColor = [UIColor clearColor];
    cancelLabel.text = @"取消";
    cancelLabel.textColor = gnh_color_a;
    cancelLabel.font = [UIFont systemFontOfSize:16.0f];
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    [groundView addSubview:cancelLabel];
    self.cancelLabel = cancelLabel;
    [cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(verlineView.mas_centerY);
        make.height.mas_equalTo(30.0f);
    }];
    [cancelLabel mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        if (weakSelf.cancelCallBack ) {
            weakSelf.cancelCallBack();
        }
    }];
    
    UILabel *confirmLabel = [[UILabel alloc] init];
    confirmLabel.backgroundColor = [UIColor clearColor];
    confirmLabel.text = @"确认";
    confirmLabel.textColor = gnh_color_m;
    confirmLabel.font = [UIFont systemFontOfSize:16.0f];
    confirmLabel.textAlignment = NSTextAlignmentCenter;
    [groundView addSubview:confirmLabel];
    self.confirmLabel = confirmLabel;
    [confirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(verlineView.mas_centerY);
        make.height.mas_equalTo(30.0f);
    }];
    [confirmLabel mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        NSString *introduce = contentTextField.text;
        if (!introduce.length) {
            [SVProgressHUD showInfoWithStatus:@"请介绍一下自己吧～"];
        } else {
            if (completeBlock) {
                completeBlock(ZYAlertViewActionTypeActionTypeConfirm, introduce);
            }
        }
    }];
    
    [@[cancelLabel, confirmLabel] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:13.0f leadSpacing:35.0f tailSpacing:35.0f];
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.35 animations:^{
        self.groundView.frame = CGRectOffset(self.groundView.frame, 0, -50);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.35 animations:^{
        self.groundView.frame = CGRectOffset(self.groundView.frame, 0, 50);
    }];
}

@end
