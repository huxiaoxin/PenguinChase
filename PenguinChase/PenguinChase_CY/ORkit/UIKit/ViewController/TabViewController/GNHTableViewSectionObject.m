//
//  GNHTableViewSectionObject.m
//  GeiNiHua
//
//  Created by ChenYuan on 2017/11/22.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHTableViewSectionObject.h"

@implementation GNHTableViewSectionObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _headerHeight = 0;
        _footerHeight = CGFLOAT_MIN;
    }
    return self;
}

#pragma mark - Properties

- (void)setIsNeedHeaderTableViewCell:(BOOL)isNeedHeaderTableViewCell
{
    GNHHearderViewTableViewCellItem *headerCellItem = (GNHHearderViewTableViewCellItem *)self.items.firstObject;
    if (isNeedHeaderTableViewCell) {
        if (![headerCellItem isMemberOfClass:[GNHHearderViewTableViewCellItem class]]) {
            headerCellItem = [[GNHHearderViewTableViewCellItem alloc] init];
            [self.items mdf_safeInsertObject:headerCellItem atIndex:0];
        }
    } else {
        if ([headerCellItem isMemberOfClass:[GNHHearderViewTableViewCellItem class]]) {
            [self.items mdf_safeRemoveObject:headerCellItem];
        }
    }
}

- (void)setHeaderTableViewCellItem:(GNHHearderViewTableViewCellItem *)headerTableViewCellItem
{
    _headerTableViewCellItem = headerTableViewCellItem;
    
    GNHHearderViewTableViewCellItem *headerCellItem = (GNHHearderViewTableViewCellItem *)self.items.firstObject;
    if ([headerCellItem isMemberOfClass:[GNHHearderViewTableViewCellItem class]]) {
        headerCellItem.isShowMore = headerTableViewCellItem.isShowMore;
        headerCellItem.title = headerTableViewCellItem.title;
        headerCellItem.gap = headerTableViewCellItem.gap;
        headerCellItem.moduleType = headerTableViewCellItem.moduleType;
        headerCellItem.rightSubTitle = headerTableViewCellItem.rightSubTitle;
        headerCellItem.isShowPadView = headerTableViewCellItem.isShowPadView;
    }
}

- (void)setIsNeedFooterTableViewCell:(BOOL)isNeedFooterTableViewCell
{
    GNHFooterViewTableViewCellItem *footerCellItem = (GNHFooterViewTableViewCellItem *)self.items.lastObject;
    if (isNeedFooterTableViewCell) {
        if (![footerCellItem isMemberOfClass:[GNHFooterViewTableViewCellItem class]]) {
            footerCellItem = [[GNHFooterViewTableViewCellItem alloc] init];
            [self.items mdf_safeAddObject:footerCellItem];
        }
    } else {
        if ([footerCellItem isMemberOfClass:[GNHFooterViewTableViewCellItem class]]) {
            [self.items mdf_safeRemoveObject:footerCellItem];
        }
    }
}

- (void)setFooterTableViewCellHeight:(CGFloat)footerTableViewCellHeight
{
    _footerTableViewCellHeight = footerTableViewCellHeight;
    
    GNHFooterViewTableViewCellItem *footerCellItem = (GNHFooterViewTableViewCellItem *)self.items.lastObject;
    if ([footerCellItem isMemberOfClass:[GNHFooterViewTableViewCellItem class]]) {
        footerCellItem.cellHeight = footerTableViewCellHeight;
    }
}

- (void)setIsNeedGapTableViewCell:(BOOL)isNeedGapTableViewCell
{
    GNHFooterViewTableViewCellItem *gapCellItem = (GNHFooterViewTableViewCellItem *)self.items.firstObject;
    if (isNeedGapTableViewCell) {
        if (![gapCellItem isMemberOfClass:[GNHFooterViewTableViewCellItem class]]) {
            gapCellItem = [[GNHFooterViewTableViewCellItem alloc] init];
            [self.items mdf_safeInsertObject:gapCellItem atIndex:0];
        }
    } else {
        if ([gapCellItem isMemberOfClass:[GNHHearderViewTableViewCellItem class]]) {
            [self.items mdf_safeRemoveObject:gapCellItem];
        }
    }
}

- (void)setGapTableViewCellHeight:(CGFloat)gapTableViewCellHeight
{
    _gapTableViewCellHeight = gapTableViewCellHeight;
    
    GNHFooterViewTableViewCellItem *gapCellItem = (GNHFooterViewTableViewCellItem *)self.items.firstObject;
    if ([gapCellItem isMemberOfClass:[GNHFooterViewTableViewCellItem class]]) {
        gapCellItem.cellHeight = gapTableViewCellHeight;
    }
}

@end
