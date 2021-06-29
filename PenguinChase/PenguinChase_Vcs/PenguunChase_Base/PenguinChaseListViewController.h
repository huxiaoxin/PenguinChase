//
//  PenguinChaseListViewController.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChase_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseListViewController : PenguinChase_BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * PenguinChaseTableView;
@end

NS_ASSUME_NONNULL_END
