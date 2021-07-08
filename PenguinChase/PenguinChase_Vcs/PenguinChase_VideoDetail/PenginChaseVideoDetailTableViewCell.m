#import "PenginChaseVideoDetailTableViewCell.h"
#import "WWStarView.h"
@interface PenginChaseVideoDetailTableViewCell ()
@property(nonatomic,strong)  UIImageView * PenguinChaseThubImgView;
@property(nonatomic,strong) UILabel      * PenguinChaseNamelb;
@property(nonatomic,strong) WWStarView   * PenguinChaseStarView;
@property(nonatomic,strong) UILabel      * PenguinChaseNumlb;
@property(nonatomic,strong) UILabel      * PenguinChaseContentlb;
@property(nonatomic,strong) UIView       * PenguinChaseLine;
@property(nonatomic,strong) UIButton   * PenguiChaseLHBtn;
@property(nonatomic,strong) UIButton   * PenguinChaseJBBtn;
@end
@implementation PenginChaseVideoDetailTableViewCell
-(void)PenguinChaseAddSubViews{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.PenguinChaseThubImgView];
    [self.contentView addSubview:self.PenguinChaseNamelb];
    [self.contentView addSubview:self.PenguinChaseStarView];
    [self.contentView addSubview:self.PenguinChaseNumlb];
    [self.contentView addSubview:self.PenguinChaseJBBtn];
    [self.contentView addSubview:self.PenguiChaseLHBtn];
    [self.contentView addSubview:self.PenguinChaseContentlb];
    [self.contentView addSubview:self.PenguinChaseLine];
    
    
    
}
- (UIView *)PenguinChaseLine{
    if (!_PenguinChaseLine) {
        _PenguinChaseLine = [[UIView alloc]initWithFrame:CGRectMake(RealWidth(15), 0, GK_SCREEN_WIDTH-RealWidth(15), RealWidth(1))];
        _PenguinChaseLine.backgroundColor = LGDLightGaryColor;
    }
    return _PenguinChaseLine;
}
- (UIImageView *)PenguinChaseThubImgView{
    if (!_PenguinChaseThubImgView) {
        _PenguinChaseThubImgView = [[UIImageView alloc]initWithFrame:CGRectMake(RealWidth(15), RealWidth(15), RealWidth(40), RealWidth(40))];
        _PenguinChaseThubImgView.layer.cornerRadius = RealWidth(20);
        _PenguinChaseThubImgView.layer.masksToBounds =  YES;
    }
    return _PenguinChaseThubImgView;
}
- (UILabel *)PenguinChaseNamelb{
    if (!_PenguinChaseNamelb) {
        _PenguinChaseNamelb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PenguinChaseThubImgView.frame)+RealWidth(5), RealWidth(5)+CGRectGetMinY(_PenguinChaseThubImgView.frame), RealWidth(200), RealWidth(15))];
        _PenguinChaseNamelb.textColor = LGDBLackColor;
        _PenguinChaseNamelb.font = [UIFont boldSystemFontOfSize:14];
        _PenguinChaseNamelb.text = @"小明明";
    }
    return _PenguinChaseNamelb;
}
- (WWStarView *)PenguinChaseStarView{
    if (!_PenguinChaseStarView) {
        _PenguinChaseStarView = [[WWStarView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PenguinChaseThubImgView.frame)+RealWidth(5), CGRectGetMaxY(_PenguinChaseNamelb.frame)+RealWidth(3), RealWidth(50), RealWidth(15)) numberOfStars:5 currentStar:2 rateStyle:HalfStar isAnination:YES andamptyImageName:@"xingxing-nomal" fullImageName:@"xingxing" finish:^(CGFloat currentStar) {
            
        }];
        
    }
    return _PenguinChaseStarView;
}
- (UIButton *)PenguiChaseLHBtn{
    if (!_PenguiChaseLHBtn) {
        _PenguiChaseLHBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize LHBtnSize = [@"拉黑" cxl_sizeWithString:KBlFont(14)];
        [_PenguiChaseLHBtn setFrame:CGRectMake(CGRectGetMinX(_PenguinChaseJBBtn.frame)-LHBtnSize.width-RealWidth(10), CGRectGetMidY(_PenguinChaseThubImgView.frame)-RealWidth(7.5), LHBtnSize.width+RealWidth(10), RealWidth(15))];
        _PenguiChaseLHBtn.tag = 0;
        [_PenguiChaseLHBtn setTitle:@"拉黑" forState:UIControlStateNormal];
        [_PenguiChaseLHBtn setTitleColor:LGDMianColor forState:UIControlStateNormal];
        _PenguiChaseLHBtn.titleLabel.font = KBlFont(14);
        [_PenguiChaseLHBtn addTarget:self action:@selector(PenguiChaseLHBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PenguiChaseLHBtn;
}
- (UIButton *)PenguinChaseJBBtn{
    if (!_PenguinChaseJBBtn) {
        _PenguinChaseJBBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize JBBtnSize = [@"举报" cxl_sizeWithString:KBlFont(14)];
        [_PenguinChaseJBBtn setFrame:CGRectMake(GK_SCREEN_WIDTH-RealWidth(15)-JBBtnSize.width, CGRectGetMidY(_PenguinChaseThubImgView.frame)-RealWidth(7.5), JBBtnSize.width+RealWidth(10), RealWidth(15))];
        _PenguinChaseJBBtn.tag = 1;
        [_PenguinChaseJBBtn setTitle:@"举报" forState:UIControlStateNormal];
        [_PenguinChaseJBBtn setTitleColor:LGDMianColor forState:UIControlStateNormal];
        [_PenguinChaseJBBtn addTarget:self action:@selector(PenguinChaseJBBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _PenguinChaseJBBtn.titleLabel.font = KBlFont(14);
    }
    return _PenguinChaseJBBtn;
}
- (UILabel *)PenguinChaseNumlb{
    if (!_PenguinChaseNumlb) {
        _PenguinChaseNumlb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PenguinChaseStarView.frame)+RealWidth(5), CGRectGetMidY(_PenguinChaseStarView.frame)-RealWidth(7.5), RealWidth(200), RealWidth(15))];
        _PenguinChaseNumlb.textColor = LGDBLackColor;
        _PenguinChaseNumlb.font = [UIFont boldSystemFontOfSize:12];
        _PenguinChaseNumlb.text = @"8.5";
    }
    return _PenguinChaseNumlb;
}
- (UILabel *)PenguinChaseContentlb{
    if (!_PenguinChaseContentlb) {
        _PenguinChaseContentlb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PenguinChaseThubImgView.frame)+RealWidth(5), CGRectGetMaxY(_PenguinChaseThubImgView.frame)+RealWidth(10), GK_SCREEN_WIDTH-CGRectGetMaxX(_PenguinChaseThubImgView.frame)-RealWidth(10), RealWidth(40))];
        _PenguinChaseContentlb.numberOfLines =  0;
        _PenguinChaseContentlb.font = [UIFont systemFontOfSize:RealWidth(14)];
    }
    return _PenguinChaseContentlb;
}
- (void)setPengModel:(PenguinChaseVideoComentModel *)pengModel{
    _pengModel = pengModel;
    [_PenguinChaseThubImgView sd_setImageWithURL:[NSURL URLWithString:pengModel.userHeadeurl] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    _PenguinChaseStarView.currentStar = pengModel.starNum;
    _PenguinChaseNamelb.text = pengModel.userName;
    [_PenguinChaseContentlb setText:pengModel.content lineSpacing:3];
   CGSize penguinContentSize  = [_PenguinChaseContentlb getSpaceLabelSize:pengModel.content withFont:[UIFont systemFontOfSize:RealWidth(14)] withWidth:GK_SCREEN_WIDTH -CGRectGetMaxX(_PenguinChaseThubImgView.frame)-RealWidth(10) lineSpacing:3];
    _PenguinChaseNumlb.text = [NSString stringWithFormat:@"%.2ld",(long)pengModel.soureNum];
    _PenguinChaseContentlb.frame = CGRectMake(CGRectGetMaxX(_PenguinChaseThubImgView.frame)+RealWidth(5), CGRectGetMaxY(_PenguinChaseThubImgView.frame)+RealWidth(10), penguinContentSize.width, penguinContentSize.height);
    _PenguinChaseLine.y = CGRectGetMaxY(_PenguinChaseContentlb.frame)+RealWidth(5);
    [self setNeedsLayout];
    [self  layoutIfNeeded];
    
    pengModel.CellHeight = CGRectGetMaxY(_PenguinChaseLine.frame);
    
    
    
}
-(void)PenguiChaseLHBtnClick{
    [self.delegate PenginChaseVideoDetailTableViewCellPenguinWithBtnAction:0 cellIndex:self.tag];
    
}
-(void)PenguinChaseJBBtnClick{
    [self.delegate PenginChaseVideoDetailTableViewCellPenguinWithBtnAction:1 cellIndex:self.tag];

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

