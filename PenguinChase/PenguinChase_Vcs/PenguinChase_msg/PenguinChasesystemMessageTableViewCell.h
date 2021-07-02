//
//  PenguinChasesystemMessageTableViewCell.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/30.
//

#import "PenguinChaseBaseTableViewCell.h"
#import "PenguinsystemMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PenguinChasesystemMessageTableViewCell : PenguinChaseBaseTableViewCell
@property(nonatomic,copy) PenguinsystemMessageModel * penguinMessageModel;
@end

NS_ASSUME_NONNULL_END
