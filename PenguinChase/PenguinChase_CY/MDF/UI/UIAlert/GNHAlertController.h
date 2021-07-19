//
//  GNHAlertController.h
//  GeiNiHua
//
//  Created by ChenYuan on 2017/3/17.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 实例:self(UIViewController对象)
 [self gnh_showAlertWithTitle:@"温馨提示" message:@"使用实例" appearanceProcess:^(GNHAlertController *alertMaker) {
     alertMaker
     .addActionCancelTitle(@"取消")
     .addActionDefaultTitle(@"确定");
 } actionsBlock:^(NSInteger index, UIAlertAction *action, GNHAlertController *alertMaker) {
 }];
 */


@class GNHAlertController;

/**
 alert按钮执行回调

 @param index 按钮index(根据添加action的顺序)
 @param action UIAlertAction对象
 @param alertMaker GNHAlertController对象
 */
typedef void (^GNHAlertActionBlock)(NSInteger index, UIAlertAction *action, GNHAlertController *alertMaker);

/**
 alertAction 配置链

 @param title 标题
 @return GNHAlertController对象
 */
typedef GNHAlertController *(^GNHAlertActionTitle)(NSString *title);
#pragma mark - I.GNHAlertController
@interface GNHAlertController : UIAlertController
/**
 *  设置toast模式展示时间：如果alert未添加任何按钮，将会以toast样式展开，这里设置展示时间，默认1.5s
 */
@property (nonatomic, assign) NSTimeInterval toastStyleDuration;
@property (nonatomic, copy) void (^toastStyleDidDismiss)(void); /** toastStyle关闭后 */
@property (nonatomic, assign) BOOL gnh_AlertAnimated; /** 弹框展示与消失动画，默认YES */
@property (nonatomic, copy) void (^alertDidShow)(void); /** alert弹出后 */
/**
 链式构造alert视图按钮，添加alertAction按钮，默认样式

 @return 链式 block
 */
- (GNHAlertActionTitle)addActionDefaultTitle;

/**
 链式构造alert视图按钮，添加alertAction按钮，取消样式，（注意：一个alert只能添加一次该样式）

 @return 链式 block
 */
- (GNHAlertActionTitle)addActionCancelTitle;

/**
 链式构造alert视图按钮，添加alertAction按钮，警告样式
 
 @return 链式 block
 */
- (GNHAlertActionTitle)addActionDestructiveTitle;
@end

#pragma mark - II.GNHAlertController扩展使用GNHAlertController

/** alert构造
 
 @param alertMaker GNHAlertController对象
 */
typedef void (^GNHAlertAppearanceProcess)(GNHAlertController *alertMaker);

@interface UIViewController (GNHAlertController)

/** alert弹框
 
 @param title               title
 @param message             message
 @param appearanceProcess   alert配置过程
 @param actionsBlock        alert点击响应回调
 */
- (void)gnh_showAlertWithTitle:(NSString *)title
                       message:(NSString *)message
             appearanceProcess:(GNHAlertAppearanceProcess)appearanceProcess
                  actionsBlock:(GNHAlertActionBlock)actionsBlock;
/** sheet弹框
 
 @param title               title
 @param message             message
 @param appearanceProcess   alert配置过程
 @param actionsBlock        alert点击响应回调
 */
- (void)gnh_showSheetWithTitle:(NSString *)title
                       message:(NSString *)message
             appearanceProcess:(GNHAlertAppearanceProcess)appearanceProcess
                  actionsBlock:(GNHAlertActionBlock)actionsBlock;

@end



