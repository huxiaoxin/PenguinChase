//
//  PenguinChaseComentListTableViewCell.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseBaseTableViewCell.h"
#import "PenguinChaseComentModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol PenguinChaseComentListTableViewCellDelegate <NSObject>

-(void)PenguinChaseComentListTableViewCellWithbtnClikcIndex:(NSInteger)btnIndex cellIndex:(NSInteger)CellIndex;

@end
@interface PenguinChaseComentListTableViewCell : PenguinChaseBaseTableViewCell
@property(nonatomic,strong) PenguinChaseComentModel * penguinModel;
@property(nonatomic,weak) id <PenguinChaseComentListTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
