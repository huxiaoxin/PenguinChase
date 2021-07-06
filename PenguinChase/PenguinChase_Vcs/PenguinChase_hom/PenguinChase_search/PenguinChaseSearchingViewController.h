//
//  PenguinChaseSearchingViewController.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/6.
//

#import "PenguinChaseListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseSearchingViewController : PenguinChaseListViewController
@property(nonatomic,assign) NSInteger  searchID;
@property(nonatomic,copy) NSString * searchContent;
@end

NS_ASSUME_NONNULL_END
