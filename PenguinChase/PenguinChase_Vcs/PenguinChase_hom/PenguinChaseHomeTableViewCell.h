//
//  PenguinChaseHomeTableViewCell.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import "PenguinChaseBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PenguinChaseHomeTableViewCellDelegate <NSObject>

-(void)PenguinChaseHomeTableViewCellWithWantbtnAction:(NSInteger)btnIndex;

@end
@interface PenguinChaseHomeTableViewCell : PenguinChaseBaseTableViewCell
@property(nonatomic,strong) PenguinChaseVideoModel * penguinModel;
@property(nonatomic,weak) id <PenguinChaseHomeTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
