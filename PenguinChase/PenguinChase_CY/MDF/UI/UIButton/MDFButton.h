//
//  MDFButton.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/24.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDFButton : UIButton

@property (nonatomic, assign) UIEdgeInsets touchEdgeInsets; // 扩展的点击区域 （负值为加大，正值减少）
@property (nonatomic, assign, readonly) CGRect touchFrame;  // 扩展后的包括点击区域的 frame
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIFont *normalFont; // 正常字体
@property (nonatomic, strong) UIFont *highlightedFont; // 高亮字体
@property (nonatomic, strong) UIFont *selectedFont;    // 选中字体
@property (nonatomic, strong) UIFont *disabledFont;    // 不可编辑字体

/**
 * Set a font for a button state.
 *
 * @param font  the font
 * @param state a control state -- can be
 *      UIControlStateNormal
 *      UIControlStateHighlighted
 *      UIControlStateDisabled
 *      UIControlStateSelected
 */
- (void)setFont:(UIFont *)font forState:(NSUInteger)state;

@end
