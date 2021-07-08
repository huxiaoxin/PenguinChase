//
//  PenguinChaseBangdanTableViewCell.h
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PenguinChaseBangdanTableViewCellDelegate <NSObject>

-(void)PenguinChaseBangdanTableViewCellWithWantchWithIndex:(NSInteger)CellIndex;
-(void)PenguinChaseBangdanTableViewCellWithBannerIndex:(NSInteger)bannerIndex CellIndx:(NSInteger)cellIndex;
@end
@interface PenguinChaseBangdanTableViewCell : PenguinChaseBaseTableViewCell
@property(nonatomic,strong) PenguinChaseVideoModel * penguinModel;
@property(nonatomic,weak) id <PenguinChaseBangdanTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
