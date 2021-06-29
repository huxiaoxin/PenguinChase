//
//  PenguinChaseHuatiSearchView.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PenguinSeachTapBlock)(void);
@interface PenguinChaseHuatiSearchView : UIView
-(instancetype)initWithFrame:(CGRect)frame  SearchTapAction:(PenguinSeachTapBlock)searchBlock;
@end

NS_ASSUME_NONNULL_END
