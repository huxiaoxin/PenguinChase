//
//  PenguinChaseMessageTableViewCell.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/30.
//

#import "PenguinChaseBaseTableViewCell.h"
#import "PenguinChatMessageListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseMessageTableViewCell : PenguinChaseBaseTableViewCell
@property(nonatomic,strong) PenguinChatMessageListModel * penglistModel;
@end

NS_ASSUME_NONNULL_END
