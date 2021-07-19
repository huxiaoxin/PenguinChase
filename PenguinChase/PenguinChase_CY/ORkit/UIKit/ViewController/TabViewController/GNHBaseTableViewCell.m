//
//  GNHBaseTableViewCell.m
//  GeiNiHua
//
//  Created by ChenYuan on 2017/11/22.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHBaseTableViewCell.h"

@implementation GNHBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    GNHWeakSelf;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.lineColor = gnh_color_p;
    self.topLineEdgeInsets = UIEdgeInsetsZero;
    self.bottomLineEdgeInsets = UIEdgeInsetsZero;

    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = _lineColor;
    topLine.hidden = YES;
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(0.5);
    }];
    _topLine = topLine;
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = _lineColor;
    bottomLine.hidden = YES;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.mas_equalTo(0.5);
    }];
    _bottomLine = bottomLine;
}

#pragma mark - Config

// 给section 的第一个和最后一个item加线
- (void)configTopAndBottomLine
{
    switch (self.cellLocationType) {
        case GNHBaseTableviewCellLocationTypeOneCell: {
            self.topLine.hidden = NO;
            self.bottomLine.hidden = NO;
            break;
        }
        case GNHBaseTableviewCellLocationTypeTopCell: {
            self.topLine.hidden = NO;
            self.bottomLine.hidden = YES;
            break;
        }
        case GNHBaseTableviewCellLocationTypeMiddleCell: {
            self.topLine.hidden = YES;
            self.bottomLine.hidden = YES;
            break;
        }
        case GNHBaseTableviewCellLocationTypeBottomCell: {
            self.topLine.hidden = YES;
            self.bottomLine.hidden = NO;
            break;
        }
        default:
            break;
    }
}

+ (CGFloat)heightForItem:(id)item
{
    if ([item isKindOfClass:[GNHBaseItem class]]) {
        CGFloat height = ((GNHBaseItem *)item).cellHeight;
        if (height > 0) {
            return height;
        }
    }
    return 45.0f;
}

#pragma mark - Properties

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    _item = item;
}

- (void)setTopLineEdgeInsets:(UIEdgeInsets)topLineEdgeInsets
{
    _topLineEdgeInsets = topLineEdgeInsets;
    
    GNHWeakSelf;
    [self.topLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(weakSelf.topLineEdgeInsets.top);
        make.left.mas_equalTo(weakSelf.mas_left).offset(weakSelf.topLineEdgeInsets.left);
        make.right.mas_equalTo(weakSelf.mas_right).offset(weakSelf.topLineEdgeInsets.right);
    }];
}

- (void)setBottomLineEdgeInsets:(UIEdgeInsets)bottomLineEdgeInsets
{
    _bottomLineEdgeInsets = bottomLineEdgeInsets;
    
    GNHWeakSelf;
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(weakSelf.bottomLineEdgeInsets.left);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-weakSelf.bottomLineEdgeInsets.bottom);
        make.right.mas_equalTo(weakSelf.mas_right).offset(weakSelf.bottomLineEdgeInsets.right);
    }];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.topLine.backgroundColor = lineColor;
    self.bottomLine.backgroundColor = lineColor;
}

@end
