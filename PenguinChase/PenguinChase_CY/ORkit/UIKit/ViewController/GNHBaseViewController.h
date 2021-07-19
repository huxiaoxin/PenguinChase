//
//  GNHBaseViewController.h
//  GeiNiHua
//
//  Created by ChenYuan on 2016/10/9.
//  Copyright © 2016年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORMainAPI.h"
#import "GNHBaseDataModel.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#pragma mark - GNHBaseViewController
@interface GNHBaseViewController : UIViewController <GNHBaseDataModelDelegate>

#pragma mark - Action

- (void)leftButtonAction:(UIButton *)btn;

- (void)rightButtonAction:(UIButton *)btn;

- (void)titleButtonAction:(UIButton *)btn;

#pragma mark - Interface

/**
 * View controller was First time appear
 */
- (BOOL)viewControllerAppearAtFirstTime;

#pragma mark - Override

/**
 *  View controller was popped or dismissed
 */
- (void)viewControllerWillDisappear;

/**
 *  View controller was popped or dismissed
 */
- (void)viewControllerDidDisappear;

/**
 * 设置通知
 */
- (void)setupNotifications;

/**
 * 设置数据加载model，所有UI 相关 model都需要收敛到该方法中
 */
- (void)setupDataModels NS_REQUIRES_SUPER;

/**
 * 需要显示请求菊花的Model
 */
- (__kindof NSArray *)autoShowSVPWithDataModel;

// 是否 view did appeared
@property (nonatomic, assign) BOOL isViewDidAppeared;
@property (nonatomic, assign) BOOL isViewAppearing;
@property (nonatomic, assign) BOOL isShouldOrientationMaskAll;


@property (nonatomic, copy) dispatch_block_t viewWillDisappearBlock;
@property (nonatomic, copy) dispatch_block_t viewDidAppearBlock;

@end

#pragma mark - model & network UIs

@interface GNHBaseViewController (Model) <GNHDataModelUtilProtocol>

/**
 *  数据请求成功回调
 *
 *  @param gnhModel 数据加载model
 */
- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel NS_REQUIRES_SUPER;

/**
 *  数据请求失败回调
 *
 *  @param gnhModel 数据加载model
 */
- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel NS_REQUIRES_SUPER;

@end
