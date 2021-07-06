//
//  PenguinCenterListTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinCenterListTableViewCell.h"
@interface PenguinCenterListTableViewCell ()
@property(nonatomic,strong) UIImageView * penguinLeftimgView;
@property(nonatomic,strong) UILabel    * PenguinNamelb;
@property(nonatomic,strong) UIImageView * PenguinRightimg;
@property(nonatomic,strong) UILabel     * PenguinRightlb;
@property(nonatomic,strong) UIView    * penguinBtomline;
@end
@implementation PenguinCenterListTableViewCell
-(void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.penguinLeftimgView];
    [self.contentView addSubview:self.PenguinNamelb];
    [self.contentView addSubview:self.PenguinRightimg];
    [self.contentView addSubview:self.PenguinRightlb];
    [self.contentView addSubview:self.penguinBtomline];
    [_penguinLeftimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RealWidth(20));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(RealWidth(20), RealWidth(20)));
    }];
    
    [_PenguinNamelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_penguinLeftimgView.mas_right).offset(RealWidth(5));
        make.centerY.mas_equalTo(_penguinLeftimgView.mas_centerY);
    }];
    [_penguinBtomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_penguinLeftimgView.mas_left);
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-RealWidth(20));
        make.height.mas_equalTo(1);
    }];
    [_PenguinRightimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-RealWidth(20));
        make.size.mas_equalTo(CGSizeMake(RealWidth(15), RealWidth(15)));
    }];
    
    [_PenguinRightlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(_PenguinRightimg.mas_left);
    }];
}
- (UIImageView *)penguinLeftimgView{
    if (!_penguinLeftimgView) {
        _penguinLeftimgView = [UIImageView new];
    }
    return _penguinLeftimgView;
}
-(UILabel *)PenguinNamelb{
    if (!_PenguinNamelb) {
        _PenguinNamelb = [UILabel new];
        _PenguinNamelb.textColor = LGDLightBLackColor;
        _PenguinNamelb.font = [UIFont boldSystemFontOfSize:14];
    }
    return _PenguinNamelb;
}
- (UIView *)penguinBtomline{
    if (!_penguinBtomline) {
        _penguinBtomline = [UIView new];
        _penguinBtomline.backgroundColor = LGDLightGaryColor;
    }
    return _penguinBtomline;
}
- (UILabel *)PenguinRightlb{
    if (!_PenguinRightlb) {
        _PenguinRightlb = [UILabel new];
        _PenguinRightlb.textColor = LGDGaryColor;
        _PenguinRightlb.font = [UIFont boldSystemFontOfSize:12];
        _PenguinRightlb.text = @"0.12M";
    }
    return _PenguinRightlb;
}
- (UIImageView *)PenguinRightimg{
    if (!_PenguinRightimg) {
        _PenguinRightimg =  [UIImageView new];
//        _PenguinRightimg.backgroundColor = LGDMianColor;
        _PenguinRightimg.image = [UIImage imageNamed:@"youbian1x"];
    }
    return _PenguinRightimg;
}
- (void)setPenguinText:(NSString *)penguinText{
    _penguinText = penguinText;
    _PenguinNamelb.text = penguinText;
    _penguinLeftimgView.image = [UIImage imageNamed:penguinText];
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
