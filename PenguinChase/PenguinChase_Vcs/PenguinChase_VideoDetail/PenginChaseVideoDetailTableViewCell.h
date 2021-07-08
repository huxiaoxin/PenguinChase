//
//  PenginChaseVideoDetailTableViewCell.h
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseBaseTableViewCell.h"
#import "PenguinChaseVideoComentModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol PenginChaseVideoDetailTableViewCellDelegate <NSObject>

-(void)PenginChaseVideoDetailTableViewCellPenguinWithBtnAction:(NSInteger)btnIndex cellIndex:(NSInteger)cellIndex;

@end
@interface PenginChaseVideoDetailTableViewCell : PenguinChaseBaseTableViewCell
@property(nonatomic,strong) PenguinChaseVideoComentModel * pengModel;
@property(nonatomic,weak) id <PenginChaseVideoDetailTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
