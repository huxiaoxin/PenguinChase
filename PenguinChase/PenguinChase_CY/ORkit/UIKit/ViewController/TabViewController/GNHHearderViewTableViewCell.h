//
//  GNHHearderViewTableViewCell.h
//  GeiNiHua
//
//  Created by ChenYuan on 2018/3/7.
//  Copyright © 2018年 GNH. All rights reserved.
//

#import "GNHBaseTableViewCell.h"

/**
 表头点击Block

 @param section 对应section
 */
typedef void(^GNHHearderViewTouchBlock)(NSInteger section);

@interface GNHHearderViewTableViewCellItem : GNHBaseItem

@property (nonatomic, copy) NSString *title;   // 标题
@property (nonatomic, copy) NSString *rightSubTitle;// 右侧标题
@property (nonatomic, assign) BOOL isShowMore; // 是否显示右侧 更多项 YES-是，NO-隐藏
@property (nonatomic, assign) CGFloat gap; // 坐标间距

@property (nonatomic, assign) NSInteger moduleType; // 模板类型

@property (nonatomic, assign) BOOL isShowPadView; // 是否显示左边竖条间隔

@end

@interface GNHHearderViewTableViewCell : GNHBaseTableViewCell

@property (nonatomic, copy) GNHHearderViewTouchBlock hearderViewTouchBlock;

@end
