//
//  GNHBaseTableViewCell.h
//  GeiNiHua
//
//  Created by ChenYuan on 2017/11/22.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNHBaseActionItemProtocol.h"

typedef NS_ENUM(NSUInteger, GNHBaseTableviewCellLocationType) {
    GNHBaseTableviewCellLocationTypeUnknown = 0,
    GNHBaseTableviewCellLocationTypeOneCell = 1,
    GNHBaseTableviewCellLocationTypeTopCell = 2,
    GNHBaseTableviewCellLocationTypeMiddleCell = 3,
    GNHBaseTableviewCellLocationTypeBottomCell = 4
};

@interface GNHBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id<GNHBaseActionItemProtocol> item;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) GNHBaseTableviewCellLocationType cellLocationType; // cell的位置
@property (nonatomic, strong, readonly) UIView *topLine;
@property (nonatomic, strong, readonly) UIView *bottomLine;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) UIEdgeInsets topLineEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets bottomLineEdgeInsets;

/// 初始化init
- (void)setupSubviews;

/// 配置cell线
- (void)configTopAndBottomLine;

/// 返回指定Item的高度
+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item;

@end
