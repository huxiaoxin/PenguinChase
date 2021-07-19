//
//  GNHHearderViewTableViewCell.m
//  GeiNiHua
//
//  Created by ChenYuan on 2018/3/7.
//  Copyright © 2018年 GNH. All rights reserved.
//

#import "GNHFooterViewTableViewCell.h"

@implementation GNHFooterViewTableViewCellItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 10.0f;
    }
    return self;
}

@end

@implementation     GNHFooterViewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = LGDViewBJColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setItem:(id)item
{
    [super setItem:item];
    
    self.topLine.hidden = YES;
    self.bottomLine.hidden = YES;
}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    return ((GNHFooterViewTableViewCellItem *)item).cellHeight;
}

@end
