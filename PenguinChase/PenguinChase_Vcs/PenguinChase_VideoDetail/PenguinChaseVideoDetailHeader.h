//
//  PenguinChaseVideoDetailHeader.h
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PenguinChaseVideoDetailHeaderBlock)(CGFloat headerHeight);
@interface PenguinChaseVideoDetailHeader : UIView
@property(nonatomic,copy) PenguinChaseVideoDetailHeaderBlock headerBlock;
@end

NS_ASSUME_NONNULL_END
