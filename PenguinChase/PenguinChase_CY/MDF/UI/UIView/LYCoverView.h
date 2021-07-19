//
//  LYCoverView.h
//  GeiNiHua
//
//  Created by ChenYuan on 16/6/7.
//  Copyright © 2016年 GNH. All rights reserved.
//  遮罩层

#import <UIKit/UIKit.h>
@interface LYCoverView : UIView

/** 遮罩层

 @param view 需要被展示的view,默认居中,可通过Masonry修改位置
 @param inView 需要展示在inView上
 @return 遮罩层
 */
+ (instancetype)showView:(UIView *)view inView:(UIView *)inView;
/** 取消遮罩层 */
- (void)disMiss;

@property (nonatomic, strong) UIColor *coverColor; /**< 遮罩层颜色 */
@property (nonatomic, assign) BOOL touchDisMiss; /**< 触摸阴影层消失,默认=YES */
@property (nonatomic, copy) void (^touchDidDisMiss)(void); /**< touchDisMiss=YES 时有效 */

@end
