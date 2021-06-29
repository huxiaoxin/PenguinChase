//
//  PenguinChaseHomeFooterView.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PenguinChaseHomeFooterViewHeightBlock)(CGFloat FooterHeight);
@interface PenguinChaseHomeFooterView : UIView
@property(nonatomic,copy) PenguinChaseHomeFooterViewHeightBlock  FooterBlock;
@end

NS_ASSUME_NONNULL_END
