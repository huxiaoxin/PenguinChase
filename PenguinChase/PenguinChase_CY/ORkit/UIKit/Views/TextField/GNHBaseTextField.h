//
//  GNHBaseTextField.h
//  AiQiu
//
//  Created by ChenYuan on 2020/4/20.
//  Copyright © 2020 lesports. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GNHBaseTextField : UITextField

@property (nonatomic, assign) CGFloat leftViewGap;  // 左视图距离左边距离
@property (nonatomic, assign) CGFloat rightViewGap; // 右视图距离右边距离

@property (nonatomic, assign) CGFloat textRectLeftGap;  // 文本框距离左边距离
@property (nonatomic, assign) CGFloat editingRectLeftGap; // 编辑中的文本框距离右边距离

@end

NS_ASSUME_NONNULL_END
