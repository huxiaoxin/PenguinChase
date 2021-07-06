//
//  PenguinChaseDongtaiTableViewCell.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PenguinChaseDongtaiTableViewCellDelegate <NSObject>

-(void)PenguinChaseDongtaiTableViewCellWithBtnActionIndex:(NSInteger)btnIndex CellIndex:(NSInteger)cellIndex;

@end
@interface PenguinChaseDongtaiTableViewCell : PenguinChaseBaseTableViewCell
@property(nonatomic,weak) id <PenguinChaseDongtaiTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
