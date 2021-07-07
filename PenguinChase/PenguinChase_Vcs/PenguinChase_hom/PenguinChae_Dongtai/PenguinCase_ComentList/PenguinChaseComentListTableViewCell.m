//
//  PenguinChaseComentListTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseComentListTableViewCell.h"
@interface PenguinChaseComentListTableViewCell ()
@property(nonatomic,strong) UIImageView * PenguinThubImgView;
@property(nonatomic,strong) UILabel     * PenguinNamelb;
@property(nonatomic,strong) UILabel     * PenguinTimelb;
@property(nonatomic,strong) UILabel     * PenguinContentlb;
@property(nonatomic,strong) UIButton    * penguinJubaoBtn;
@property(nonatomic,strong) UIButton    * PenguinLaheiBtn;
@property(nonatomic,strong) UIView      * penguinBtomline;
@end
@implementation PenguinChaseComentListTableViewCell
-(void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.PenguinThubImgView];
    [self.contentView addSubview:self.PenguinNamelb];
    [self.contentView addSubview:self.PenguinTimelb];
    [self.contentView addSubview:self.PenguinContentlb];
    [self.contentView addSubview:self.penguinJubaoBtn];
    [self.contentView addSubview:self.PenguinLaheiBtn];
    [self.contentView addSubview:self.penguinBtomline];
    
    [_PenguinThubImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.inset(RealWidth(15));
        make.size.mas_equalTo(CGSizeMake(RealWidth(36), RealWidth(36)));
    }];
    [_PenguinNamelb mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(_PenguinThubImgView.mas_right).offset(RealWidth(6));
        make.centerY.mas_equalTo(_PenguinThubImgView.mas_centerY);
    }];
    [_PenguinTimelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_PenguinThubImgView.mas_centerY);
        make.right.mas_equalTo(-RealWidth(15));
    }];
    [_PenguinContentlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinThubImgView.mas_right).offset(RealWidth(6));
        make.right.mas_equalTo(-RealWidth(6));
        make.top.mas_equalTo(_PenguinNamelb.mas_bottom).offset(RealWidth(5));
    }];
    [_penguinJubaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-RealWidth(15));
        make.top.mas_equalTo(_PenguinContentlb.mas_bottom).offset(RealWidth(10));
        make.size.mas_equalTo(CGSizeMake(RealWidth(50), RealWidth(20)));
    }];
    
    [_PenguinLaheiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_penguinJubaoBtn.mas_left).offset(-RealWidth(10));
        make.top.mas_equalTo(_PenguinContentlb.mas_bottom).offset(RealWidth(10));
        make.size.mas_equalTo(CGSizeMake(RealWidth(50), RealWidth(20)));
    }];
    [_penguinBtomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinThubImgView.mas_right).offset(RealWidth(6));
        make.right.mas_equalTo(-RealWidth(6));
        make.top.mas_equalTo(_PenguinLaheiBtn.mas_bottom).offset(RealWidth(10));
        make.height.mas_offset(1);
    }];
    
    
    
}
- (UIImageView *)PenguinThubImgView{
    if (!_PenguinThubImgView) {
        _PenguinThubImgView = [UIImageView new];
        _PenguinThubImgView.layer.cornerRadius =RealWidth(18);
        _PenguinThubImgView.layer.masksToBounds = YES;
    }
    return _PenguinThubImgView;
}
- (UILabel *)PenguinNamelb{
    if (!_PenguinNamelb) {
        _PenguinNamelb = [UILabel new];
        _PenguinNamelb.textColor =  LGDBLackColor;
        _PenguinNamelb.font = [UIFont systemFontOfSize:RealWidth(15)];
        _PenguinNamelb.text = @"中华小当家";
    }
    return _PenguinNamelb;
}

- (UILabel *)PenguinTimelb{
    if (!_PenguinTimelb) {
        _PenguinTimelb = [UILabel new];
        _PenguinTimelb.textColor =  LGDGaryColor;
        _PenguinTimelb.font = [UIFont systemFontOfSize:12];
        _PenguinTimelb.text = @"上午12:00";
    }
    return _PenguinTimelb;
}
- (UILabel *)PenguinContentlb{
    if (!_PenguinContentlb) {
        _PenguinContentlb = [UILabel new];
        _PenguinContentlb.textColor = LGDLightBLackColor;
        _PenguinContentlb.numberOfLines = 0;
        _PenguinContentlb.font = [UIFont systemFontOfSize:13];
        [_PenguinContentlb setText:@"2132412314782547235147692351487623546725318764253176452137457231431423" lineSpacing:3];
    }
    return _PenguinContentlb;
}
- (UIButton *)penguinJubaoBtn{
    if (!_penguinJubaoBtn) {
        _penguinJubaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_penguinJubaoBtn setBackgroundColor:[UIColor colorWithHexString:@"FCB211" Alpha:0.5]];
        _penguinJubaoBtn.layer.cornerRadius = RealWidth(5);
        _penguinJubaoBtn.tag = 0;
        _penguinJubaoBtn.layer.masksToBounds = YES;
        [_penguinJubaoBtn setTitle:@"屏蔽" forState:UIControlStateNormal];
        _penguinJubaoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _penguinJubaoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [_penguinJubaoBtn setTitleColor:LGDMianColor forState:UIControlStateNormal];
        [_penguinJubaoBtn addTarget:self action:@selector(penguinJubaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _penguinJubaoBtn;
}
- (UIButton *)PenguinLaheiBtn{
    if (!_PenguinLaheiBtn) {
        _PenguinLaheiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_PenguinLaheiBtn setBackgroundColor:[UIColor colorWithHexString:@"20C826" Alpha:0.5]];
        _PenguinLaheiBtn.layer.cornerRadius = RealWidth(5);
        _PenguinLaheiBtn.layer.masksToBounds = YES;
        _PenguinLaheiBtn.tag = 1;
        [_PenguinLaheiBtn setTitle:@"举报" forState:UIControlStateNormal];
        _PenguinLaheiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _PenguinLaheiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [_PenguinLaheiBtn setTitleColor:[UIColor colorWithHexString:@"20C826"] forState:UIControlStateNormal];
        [_PenguinLaheiBtn addTarget:self action:@selector(penguinJubaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PenguinLaheiBtn;
}
- (UIView *)penguinBtomline{
    if (!_penguinBtomline) {
        _penguinBtomline = [UIView new];
        _penguinBtomline.backgroundColor = LGDLightGaryColor;
    }
    return _penguinBtomline;
}
- (void)setPenguinModel:(PenguinChaseComentModel *)penguinModel{
    _penguinModel = penguinModel;
    [_PenguinThubImgView sd_setImageWithURL:[NSURL URLWithString:penguinModel.headerImgurl]];
    _PenguinNamelb.text = penguinModel.userName;
    [_PenguinContentlb setText:penguinModel.content lineSpacing:1.5];
    if (penguinModel.CellHeight == 0) {
     
    }

        [self.contentView setNeedsLayout];
        [self.contentView layoutIfNeeded];
        penguinModel.CellHeight = CGRectGetMaxY(self->_penguinBtomline.frame)-RealWidth(0);

    
}
-(void)penguinJubaoBtnClick:(UIButton *)btn{
    [self.delegate PenguinChaseComentListTableViewCellWithbtnClikcIndex:btn.tag cellIndex:self.tag];
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
