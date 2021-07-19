//
//  GNHCommonPopView.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/27.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNHCommonPopView : UIView

/**
 * 配置参数
 * @param sourceView 来源view
 * @param tableView  view
 * @param item 数据源
 **/
- (void)commonPopViewWithSourceView:(UIView *)sourceView tableView:(UITableView *)tableView item:(NSObject *)item;

/**
 * 显示
 */
- (void)showDetailView;

@end
