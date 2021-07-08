//
//  PenguinChaseVideoDetailHeader.h
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import <UIKit/UIKit.h>
#import "PenguinChaseVideoModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^PenguinChaseVideoDetailHeaderBlock)(CGFloat headerHeight);
@protocol PenguinChaseVideoDetailHeaderDelegate <NSObject>

-(void)PenguinChaseVideoDetailHeaderWithWantAction:(PenguinChaseVideoModel *)PengModel;

@end
@interface PenguinChaseVideoDetailHeader : UIView
@property(nonatomic,copy) PenguinChaseVideoDetailHeaderBlock headerBlock;
@property(nonatomic,strong) PenguinChaseVideoModel * pengModel;
@property(nonatomic,weak) id <PenguinChaseVideoDetailHeaderDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
