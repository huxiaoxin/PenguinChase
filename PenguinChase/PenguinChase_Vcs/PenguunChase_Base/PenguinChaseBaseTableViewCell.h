//
//  PenguinChaseBaseTableViewCell.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseBaseTableViewCell : UITableViewCell
+(id)PenguinChasecreateCellWithTheTableView:(UITableView *)tableView AndTheIndexPath:(NSIndexPath *)indexPath;
-(void)PenguinChaseAddSubViews;
@end

NS_ASSUME_NONNULL_END
