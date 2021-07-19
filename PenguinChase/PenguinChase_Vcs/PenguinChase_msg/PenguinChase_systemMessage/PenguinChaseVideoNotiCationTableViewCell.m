
#import "PenguinChaseVideoNotiCationTableViewCell.h"
@interface PenguinChaseVideoNotiCationTableViewCell ()
@property(nonatomic,strong) UIView        * PenguinChaseContentView;
@property(nonatomic,strong) UILabel       * PenguinChaseTimelb;
@property(nonatomic,strong) UIImageView   * PenguinChaseBackImgView;
@property(nonatomic,strong) UILabel       * PenguinChaseContentlb;
@property(nonatomic,strong) UIView        * PenguinChaseLineView;
@property(nonatomic,strong) UILabel       * PenguinChaseMoreDetailb;
@end
@implementation PenguinChaseVideoNotiCationTableViewCell
-(void)PenguinChaseAddSubViews{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.PenguinChaseContentView];
    [_PenguinChaseContentView addSubview:self.PenguinChaseBackImgView];
    [_PenguinChaseContentView addSubview:self.PenguinChaseTimelb];
    [_PenguinChaseContentView addSubview:self.PenguinChaseContentlb];
    [_PenguinChaseContentView addSubview:self.PenguinChaseLineView];
    [_PenguinChaseContentView addSubview:self.PenguinChaseMoreDetailb];

    [_PenguinChaseContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(RealWidth(5), RealWidth(10), RealWidth(5), RealWidth(10)));
    }];
    [_PenguinChaseBackImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(_PenguinChaseContentView);
        make.size.mas_equalTo(CGSizeMake(RealWidth(30), RealWidth(30)));
    }];
    [_PenguinChaseTimelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_PenguinChaseContentView.mas_centerX);
        make.top.mas_equalTo(RealWidth(5));
    }];
    [_PenguinChaseContentlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.inset(RealWidth(5));
        make.right.mas_equalTo(-RealWidth(15));
        make.top.mas_equalTo(_PenguinChaseTimelb.mas_bottom).offset(RealWidth(5));
    }];
    [_PenguinChaseLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_PenguinChaseContentView);
        make.top.mas_equalTo(_PenguinChaseContentlb.mas_bottom).offset(RealWidth(5));
        make.height.mas_equalTo(1);
    }];
    [_PenguinChaseMoreDetailb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-RealWidth(5));
        make.top.mas_equalTo(_PenguinChaseLineView.mas_bottom).offset(RealWidth(5));
    }];
}
- (UIView *)PenguinChaseContentView{
    if (!_PenguinChaseContentView) {
        _PenguinChaseContentView = [UIView new];
        _PenguinChaseContentView.backgroundColor = [UIColor whiteColor];
        _PenguinChaseContentView.layer.cornerRadius = RealWidth(5);
    }
    return _PenguinChaseContentView;
}
- (UIImageView *)PenguinChaseBackImgView{
    if (!_PenguinChaseBackImgView) {
        _PenguinChaseBackImgView = [UIImageView new];
        _PenguinChaseBackImgView.image = [UIImage imageNamed:@"bianjiao"];
    }
    return _PenguinChaseBackImgView;
}
- (UILabel *)PenguinChaseTimelb{
    if (!_PenguinChaseTimelb) {
        _PenguinChaseTimelb = [UILabel new];
        _PenguinChaseTimelb.textAlignment = NSTextAlignmentCenter;
        _PenguinChaseTimelb.font = [UIFont systemFontOfSize:12];
        _PenguinChaseTimelb.textColor = LGDGaryColor;
        _PenguinChaseTimelb.text =  @"2021-06-10 15:02:03";
    }
    return _PenguinChaseTimelb;
}
- (UILabel *)PenguinChaseContentlb{
    if (!_PenguinChaseContentlb) {
        _PenguinChaseContentlb = [UILabel new];
        _PenguinChaseContentlb.numberOfLines = 0;
        _PenguinChaseContentlb.textColor = LGDBLackColor;
        _PenguinChaseContentlb.font = [UIFont systemFontOfSize:14];
        _PenguinChaseContentlb.textColor = LGDBLackColor;
        NSString * TempFirstStr  = @"【系统提醒】 ";
        NSString * TempSecondStr = @"因服务器升级需要，企鹅追剧将于2021年7月29号服务器停机进行升级";
        NSMutableParagraphStyle * parStyle = [[NSMutableParagraphStyle alloc]init];
        parStyle.lineSpacing = RealWidth(3);
        NSMutableAttributedString * mutablAtt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",TempFirstStr,TempSecondStr]];
        [mutablAtt addAttribute:NSForegroundColorAttributeName value:LGDMianColor range:NSMakeRange(0, TempFirstStr.length)];
        [mutablAtt addAttribute:NSForegroundColorAttributeName value:LGDBLackColor range:NSMakeRange(TempFirstStr.length, TempSecondStr.length)];
        [mutablAtt addAttribute:NSParagraphStyleAttributeName value:parStyle range:NSMakeRange(0, TempFirstStr.length+TempSecondStr.length)];
        _PenguinChaseContentlb.attributedText = mutablAtt;
    }
    return _PenguinChaseContentlb;
}
- (UIView *)PenguinChaseLineView{
    if (!_PenguinChaseLineView) {
        _PenguinChaseLineView = [UIView new];
        _PenguinChaseLineView.backgroundColor = LGDLightGaryColor;
    }
    return _PenguinChaseLineView;
}
- (UILabel *)PenguinChaseMoreDetailb{
    if (!_PenguinChaseMoreDetailb) {
        _PenguinChaseMoreDetailb =   [UILabel new];
        _PenguinChaseMoreDetailb.textColor= LGDGaryColor;
        _PenguinChaseMoreDetailb.font = [UIFont systemFontOfSize:13];
        _PenguinChaseMoreDetailb.text =  @"查看详情👉";
    }
    return _PenguinChaseMoreDetailb;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
