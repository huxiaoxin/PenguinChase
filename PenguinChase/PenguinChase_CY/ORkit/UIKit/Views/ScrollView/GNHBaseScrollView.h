//
//  GNHBaseScrollView.h
//  GeiNiHua
//
//  Created by ChenYuan on 2018/2/28.
//  Copyright © 2018年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNHBaseScrollView : UIScrollView
/**
 容器视图contentView内布局展示内容
 */
@property (nonatomic, weak, readonly) UIView *contentView;

@end
