
#import "PandaMovieSettingTableViewCell.h"

@implementation PandaMovieSettingCellItem

@end

@interface PandaMovieSettingTableViewCell ()

@property (nonatomic, strong) UILabel *FilmFactroytitleLabel;
@property (nonatomic, strong) UILabel *FilmFactroycontentLabel;
@property (nonatomic, strong) UIImageView *FilmFactroyarrowImageView;
@property (nonatomic, strong) UISwitch *FilmFactroyswitchButton;

@property (nonatomic, strong) PandaMovieSettingCellItem *cellItem;

@end

@implementation PandaMovieSettingTableViewCell

#pragma mark - LifeCycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = gnh_color_b;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
    
    UILabel *FilmFactroytitleLabel = [UILabel ly_LabelWithTitle:@"" font:zy_fontSize15 titleColor:gnh_color_a];
    [self.contentView addSubview:FilmFactroytitleLabel];
    FilmFactroytitleLabel.textAlignment = NSTextAlignmentLeft;
    [FilmFactroytitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15.f);
        make.centerY.equalTo(self.contentView);
    }];
    self.FilmFactroytitleLabel = FilmFactroytitleLabel;
    
    UILabel *FilmFactroycontentLabel = [UILabel ly_LabelWithTitle:@"" font:zy_fontSize15 titleColor:gnh_color_f];
    [self.contentView addSubview:FilmFactroycontentLabel];
    FilmFactroycontentLabel.textAlignment = NSTextAlignmentRight;
    [FilmFactroycontentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-36.0f);
        make.centerY.equalTo(self.contentView);
    }];
    self.FilmFactroycontentLabel = FilmFactroycontentLabel;
    self.FilmFactroycontentLabel.hidden = YES;
    
    UIImageView *FilmFactroyarrowImageView = [UIImageView ly_ImageViewWithImageName:@"pandamoview_gray_arrow"];
    [self addSubview:FilmFactroyarrowImageView];
    [FilmFactroyarrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10.0f);
        make.centerY.equalTo(self.contentView);
    }];
    self.FilmFactroyarrowImageView = FilmFactroyarrowImageView;
    
    UISwitch *FilmFactroyswitchButton = [[UISwitch alloc] init];
    [FilmFactroyswitchButton addTarget:self action:@selector(FilmFactroyswitchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    FilmFactroyswitchButton.transform = CGAffineTransformMakeScale(41/51.0, 26/31.0);
    [self.contentView addSubview:FilmFactroyswitchButton];
    [FilmFactroyswitchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15.0f);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
    [FilmFactroyswitchButton setOn:NO animated:YES];
    self.FilmFactroyswitchButton = FilmFactroyswitchButton;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    self.topLine.hidden = YES;
    self.bottomLine.hidden = NO;
    self.FilmFactroycontentLabel.hidden = YES;
    self.FilmFactroyarrowImageView.hidden = NO;
    self.FilmFactroyswitchButton.hidden = YES;
    if ([item isKindOfClass:[PandaMovieSettingCellItem class]]) {
        PandaMovieSettingCellItem *cellItem = (PandaMovieSettingCellItem *)item;
        self.cellItem = cellItem;
        self.FilmFactroytitleLabel.text = cellItem.title;
        
        self.FilmFactroycontentLabel.hidden = cellItem.content.length > 0 ? NO : YES;
        self.FilmFactroycontentLabel.text = cellItem.content;
        
        if (cellItem.cellType == ORSettingCellTypePush ||
            cellItem.cellType == ORSettingCellTypeNetwork) {
            self.FilmFactroyarrowImageView.hidden = YES;
            self.FilmFactroyswitchButton.hidden = NO;
            [self.FilmFactroyswitchButton setOn:cellItem.isOn];
        }
        
        if (cellItem.cellType == ORSettingCellTypeLogout) {
            self.bottomLine.hidden = YES;
        }
        self.bottomLineEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
        self.lineColor = gnh_color_line;
    }
}

#pragma mark - FilmFactroyswitchButtonAction

- (void)FilmFactroyswitchButtonAction:(UISwitch *)FilmFactroyswitchButton
{
    if (self.settingActionBlock) {
        self.settingActionBlock(self.cellItem.cellType, FilmFactroyswitchButton.isOn);
    }
}


#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieSettingCellItem class]]) {
        return 54.0f;
    }
    
    return 50.0f;
}

@end
