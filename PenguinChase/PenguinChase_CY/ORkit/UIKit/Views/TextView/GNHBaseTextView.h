//
//  GNHBaseTextView.h
//  GeiNiHua
//
//  Created by sanshao on 2017/5/15.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GNHBaseTextView;

typedef void(^GNHBaseTextViewDidClickBlock)(__kindof GNHBaseTextView *textView);

@interface GNHBaseTextView : UITextView
@property (nonatomic, assign) BOOL isHiddenEditMenu;  // 是否隐藏编辑Menu

/**
 创建有回调方法的按钮
 
 @param text text
 @param didClickBlock 回调方法
 @return 对象
 */
+ (instancetype)textViewWithText:(NSString *)text
                  didClickBlock:(GNHBaseTextViewDidClickBlock)didClickBlock;

@end
