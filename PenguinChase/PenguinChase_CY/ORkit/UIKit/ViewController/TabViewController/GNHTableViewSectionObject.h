//
//  GNHTableViewSectionObject.h
//  GeiNiHua
//
//  Created by ChenYuan on 2017/11/22.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNHHearderViewTableViewCell.h"
#import "GNHFooterViewTableViewCell.h"

@protocol GNHBaseActionSectionProtocol <NSObject>
@property (nonatomic, copy) NSString *didSelectSelector;

@end

@interface GNHTableViewSectionObject : NSObject <GNHBaseActionSectionProtocol>

@property (nonatomic, copy) NSString *didSelectSelector; // 点击事件

@property (nonatomic, copy) NSString *headerTitle; //section的header
@property (nonatomic, copy) NSString *footerTitle; //section的footer

@property (nonatomic, assign) CGFloat headerHeight; //header的头部高度
@property (nonatomic, assign) CGFloat footerHeight; //footer的高

@property (nonatomic, copy) NSString *identifier; //标识符

@property (nonatomic, strong) NSMutableArray *items; //section下的数据源

@property (nonatomic, assign) BOOL isNeedHeaderTableViewCell; // 是否需要headerCell，默认NO
@property (nonatomic, strong) GNHHearderViewTableViewCellItem *headerTableViewCellItem;

@property (nonatomic, assign) BOOL isNeedFooterTableViewCell; // 是否需要footerCell，默认NO
@property (nonatomic, assign) CGFloat footerTableViewCellHeight; // footerCell高度

@property (nonatomic, assign) BOOL isNeedGapTableViewCell; // 是否需要gapCell，默认NO
@property (nonatomic, assign) CGFloat gapTableViewCellHeight; // gapCell高度

@end
