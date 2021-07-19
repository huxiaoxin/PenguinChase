//
//  GNHBaseButton.h
//  GeiNiHua
//
//  Created by ChenYuan on 2017/4/26.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GNHBaseButton;

typedef void(^GNHBaseButtonDidClickBlock)(__kindof GNHBaseButton *button);

@interface GNHBaseButton : UIButton

/**
 创建有回调方法的按钮

 @param title title
 @param didClickBlock 回调方法
 @return 对象
 */
+ (instancetype)buttonWithTitle:(NSString *)title
                  didClickBlock:(GNHBaseButtonDidClickBlock)didClickBlock;
@end
