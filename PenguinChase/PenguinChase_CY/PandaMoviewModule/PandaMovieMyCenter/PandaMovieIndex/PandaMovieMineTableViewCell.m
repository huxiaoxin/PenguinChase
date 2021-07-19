

#import "PandaMovieMineTableViewCell.h"

@implementation PandaMovieMineCellItem

@end

@interface PandaMovieMineTableViewCell ()

@property (nonatomic, strong) UIView *PandaMoviebackView;
@property (nonatomic, strong) UIImageView *PandaMovieiconImageView;
@property (nonatomic, strong) UILabel *PandaMovietitleLabel;
@property (nonatomic, strong) UILabel *PandaMoviecontentLabel;
@property (nonatomic, strong) UIImageView *PandaMoviearrowImageView;

@end

@implementation PandaMovieMineTableViewCell

#pragma mark - LifeCycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = LGDViewBJColor;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
    // 背景view
    UIView *PandaMoviebackView = [UIView ly_ViewWithColor:[UIColor colorWithHexString:@"292945"]];
    PandaMoviebackView.frame = CGRectMake(15.f, 0, kScreenWidth - 30.0f, 54.0f);
    [self addSubview:PandaMoviebackView];
    self.PandaMoviebackView = PandaMoviebackView;
    
    UIImageView *PandaMovieiconImageView = [UIImageView ly_ViewWithColor:UIColor.clearColor];
    [PandaMoviebackView addSubview:PandaMovieiconImageView];
    [PandaMovieiconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PandaMoviebackView).offset(18.0f);
        make.centerY.equalTo(PandaMoviebackView);
        make.size.mas_equalTo(CGSizeMake(24.0f, 24.0f));
    }];
    self.PandaMovieiconImageView = PandaMovieiconImageView;
    
    UILabel *PandaMovietitleLabel = [UILabel ly_LabelWithTitle:@"" font:zy_fontSize14 titleColor:[UIColor whiteColor]];
    [PandaMoviebackView addSubview:PandaMovietitleLabel];
    PandaMovietitleLabel.textAlignment = NSTextAlignmentLeft;
    [PandaMovietitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(PandaMovieiconImageView.mas_right).offset(10.f);
        make.centerY.equalTo(PandaMovieiconImageView);
    }];
    self.PandaMovietitleLabel = PandaMovietitleLabel;
    
    UILabel *PandaMoviecontentLabel = [UILabel ly_LabelWithTitle:@"" font:zy_fontSize14 titleColor:RGBA_HexCOLOR(0xA9B1AF, 1.0)];
    [PandaMoviebackView addSubview:PandaMoviecontentLabel];
    PandaMoviecontentLabel.textAlignment = NSTextAlignmentRight;
    [PandaMoviecontentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(PandaMoviebackView).offset(-30.0f);
        make.centerY.equalTo(PandaMovieiconImageView);
    }];
    self.PandaMoviecontentLabel = PandaMoviecontentLabel;
    self.PandaMoviecontentLabel.hidden = YES;
    
    UIImageView *PandaMoviearrowImageView = [UIImageView ly_ImageViewWithImageName:@"padanMoview_right_arrow"];
    [PandaMoviebackView addSubview:PandaMoviearrowImageView];
    [PandaMoviearrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(PandaMoviebackView).offset(-10.0f);
        make.centerY.equalTo(PandaMoviebackView);
    }];
    self.PandaMoviearrowImageView = PandaMoviearrowImageView;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    self.topLine.hidden = YES;
    self.bottomLine.hidden = NO;
    self.PandaMoviecontentLabel.hidden = YES;
    if ([item isKindOfClass:[PandaMovieMineCellItem class]]) {
        PandaMovieMineCellItem *cellItem = (PandaMovieMineCellItem *)item;
        self.PandaMovietitleLabel.text = cellItem.title;
        self.PandaMovieiconImageView.image = [UIImage imageNamed:cellItem.iconName];
        self.PandaMoviecontentLabel.text = cellItem.content;
        
        if (cellItem.isBeginSeperator && cellItem.isEndSeperator) {
            self.PandaMoviebackView.layer.cornerRadius = 15.0f;
            self.PandaMoviebackView.layer.masksToBounds = YES;
        } else if (cellItem.isBeginSeperator) {
            // 裁上边
            [self.PandaMoviebackView cutWithCornerRadius:15.f rectCorner:UIRectCornerTopLeft | UIRectCornerTopRight];
        } else if (cellItem.isEndSeperator) {
            // 裁下边
            [self.PandaMoviebackView cutWithCornerRadius:15.f rectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight];
            self.bottomLine.hidden = YES;
        }
        self.bottomLineEdgeInsets = UIEdgeInsetsMake(0, 63, 0, -30);
    
        [self bringSubviewToFront:self.bottomLine];
        self.lineColor = LGDViewBJColor;
    }
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieMineCellItem class]]) {
        return 54.0f;
    }
    
    return 50.0f;
}

@end
