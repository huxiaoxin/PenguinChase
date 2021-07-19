//
//  UITitleView.h
//  ZhangYuSports
//
//  Created by bingbai on 2019/11/13.
//  Copyright © 2019 ChenYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ZYTitleViewCallBack)(NSInteger index);

@interface UITitleView : UIView


- (void)scrollToTag:(NSInteger)index;
@property (nonatomic, assign) NSInteger defaultIndex; /**< 默认位置 */
@property (nonatomic, strong) NSArray *titleArray; /**< 所有标题 */
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) ZYTitleViewCallBack titleCallBack;
@end

NS_ASSUME_NONNULL_END
