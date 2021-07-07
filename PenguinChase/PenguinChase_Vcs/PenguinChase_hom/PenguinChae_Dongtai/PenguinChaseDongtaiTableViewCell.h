//
//  PenguinChaseDongtaiTableViewCell.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseBaseTableViewCell.h"
#import "PenguinChaseDongtaiModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol PenguinChaseDongtaiTableViewCellDelegate <NSObject>

-(void)PenguinChaseDongtaiTableViewCellWithBtnActionIndex:(NSInteger)btnIndex CellIndex:(NSInteger)cellIndex;
-(void)PenguinChaseDongtaiTableViewCellWithChatCellIndex:(NSInteger)CellIndex;
@end
@interface PenguinChaseDongtaiTableViewCell : PenguinChaseBaseTableViewCell
@property(nonatomic,weak) id <PenguinChaseDongtaiTableViewCellDelegate>delegate;
@property(nonatomic,strong) PenguinChaseDongtaiModel * pengModel;
@end

NS_ASSUME_NONNULL_END
