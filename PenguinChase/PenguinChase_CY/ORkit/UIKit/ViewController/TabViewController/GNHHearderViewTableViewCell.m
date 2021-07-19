//
//  GNHHearderViewTableViewCell.m
//  GeiNiHua
//
//  Created by ChenYuan on 2018/3/7.
//  Copyright © 2018年 GNH. All rights reserved.
//

#import "GNHHearderViewTableViewCell.h"

@implementation GNHHearderViewTableViewCellItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 36.0f;
    }
    return self;
}

@end

@interface GNHHearderViewTableViewCell ()

@property (nonatomic, strong) UIView *padView;
@property (nonatomic, strong) UILabel *titleLabel; // 标题
@property (nonatomic, strong) UILabel *rightLabel; // 副标题
@property (nonatomic, strong) UIView *moreView;    // 更多项
@property (nonatomic, strong) GNHHearderViewTableViewCellItem *dataItem;

@end

@implementation GNHHearderViewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.separatorInset = UIEdgeInsetsZero;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
    
    UIView *padView = [[UIView alloc] initWithFrame:CGRectMake(15.0f, 10.0f, 4.0f, 15.0f)];
    padView.backgroundColor = gnh_color_k;
    padView.layer.cornerRadius = 2.0f;
    padView.layer.masksToBounds = YES;
    [self.contentView addSubview:padView];
    self.padView = padView;
    self.padView.hidden = YES;
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 10.0f, kScreenWidth - 25, 15.0f)];
    titlelabel.textColor = gnh_color_a;
    titlelabel.font = [UIFont boldSystemFontOfSize:16.f];
    titlelabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titlelabel];
    self.titleLabel = titlelabel;
    
    UIView *moreView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 50 - 5 - 6 - 16, 10.0f, 50 + 5 + 6, 17.0f)];
    [self.contentView addSubview:moreView];
    self.moreView = moreView;
    [moreView setEnlargeEdgeWithTop:30 right:30 bottom:30 left:30];
    
    GNHWeakSelf;
    [moreView mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        if (self.hearderViewTouchBlock) {
            self.hearderViewTouchBlock(weakSelf.dataItem.moduleType);
        }
    }];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50.0f, 17.0f)];
    rightLabel.text = @"更多";
    rightLabel.textColor = gnh_color_e;
    rightLabel.font = [UIFont systemFontOfSize:12.0f];
    rightLabel.textAlignment = NSTextAlignmentRight;
    [moreView addSubview:rightLabel];
    self.rightLabel = rightLabel;
    
    UIImageView *imageView = [UIImageView ly_ImageViewWithImageName:@"tab_news_more"];
    [moreView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rightLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(rightLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(6.0f, 11.4f));
    }];
}

- (void)setItem:(id)item
{
    [super setItem:item];
    
    self.topLine.hidden = YES;
    self.bottomLine.hidden = YES;
    
    if ([item isKindOfClass:[GNHHearderViewTableViewCellItem class]]) {
        GNHHearderViewTableViewCellItem *dataItem = (GNHHearderViewTableViewCellItem *)item;
        self.titleLabel.text = dataItem.title;
        self.rightLabel.text = dataItem.rightSubTitle.length ? dataItem.rightSubTitle : @"更多";
        self.moreView.hidden = !dataItem.isShowMore;
        self.dataItem = dataItem;
        self.padView.hidden = !dataItem.isShowPadView;
        
        self.titleLabel.frame = CGRectMake(15.0f, 10.0f + dataItem.gap, kScreenWidth - 25, 15.0f);
        
        /*
         * 50 - 右边文本宽度
         * 5 - 文本与右边箭头间隔
         * 6 - 箭头宽度
         * 16 - 距离右边边距
         */
        self.moreView.frame = CGRectMake(kScreenWidth - 50 - 5 - 6 - 16, 10.0f + dataItem.gap, 50 + 5 + 6, 17.0f);
        
        if (self.padView.hidden) {
            self.titleLabel.frame = CGRectMake(15.0f, 10.0f, kScreenWidth - 25, 15.0f);
        } else {
            self.titleLabel.frame = CGRectOffset(self.titleLabel.frame, 11.0f, 0);
        }
    }
}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    return ((GNHHearderViewTableViewCellItem *)item).cellHeight;
}

@end
