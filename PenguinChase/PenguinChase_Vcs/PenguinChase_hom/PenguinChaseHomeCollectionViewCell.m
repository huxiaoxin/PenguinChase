//
//  PenguinChaseHomeCollectionViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import "PenguinChaseHomeCollectionViewCell.h"
@interface PenguinChaseHomeCollectionViewCell ()
@property(nonatomic,strong) UIView * PenguinContetnView;
@property(nonatomic,strong) UIImageView * PenguinThubImgView;
@property(nonatomic,strong) UILabel    * PenguinToplb;
@property(nonatomic,strong) UILabel    * PenguinzBtomlb;
@end
@implementation PenguinChaseHomeCollectionViewCell
-(void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.PenguinContetnView];
    [_PenguinContetnView addSubview:self.PenguinThubImgView];
    [_PenguinContetnView addSubview:self.PenguinToplb];
    [_PenguinContetnView addSubview:self.PenguinzBtomlb];
    [_PenguinContetnView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.edges.mas_equalTo(self.contentView);
    }];


    [_PenguinThubImgView sd_setImageWithURL:[NSURL URLWithString:@"https://img0.baidu.com/it/u=3867090909,749683843&fm=26&fmt=auto&gp=0.jpg"] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    [_PenguinThubImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(_PenguinContetnView);
        make.height.mas_equalTo(RealWidth(120));
    }];
    [_PenguinToplb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinContetnView);
        make.top.mas_equalTo(_PenguinThubImgView.mas_bottom).offset(RealWidth(4));
        make.right.mas_equalTo(_PenguinContetnView.mas_right);
    }];
    [_PenguinzBtomlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinContetnView);
        make.top.mas_equalTo(_PenguinToplb.mas_bottom).offset(RealWidth(3));
        make.right.mas_equalTo(_PenguinContetnView.mas_right);
    }];
}
- (UILabel *)PenguinToplb{
    if (!_PenguinToplb) {
        _PenguinToplb = [UILabel new];
        _PenguinToplb.textColor = LGDBLackColor;
        _PenguinToplb.font = [UIFont boldSystemFontOfSize:15];
        _PenguinToplb.text = @"温州一家人";
    }
    return _PenguinToplb;
}
- (UILabel *)PenguinzBtomlb{
    if (!_PenguinzBtomlb) {
        _PenguinzBtomlb = [UILabel new];
        _PenguinzBtomlb.textColor = LGDLightBLackColor;
        _PenguinzBtomlb.font = [UIFont systemFontOfSize:11];
        _PenguinzBtomlb.text = @"少龙星云第一次相遇";
    }
    return _PenguinzBtomlb;
}
- (UIView *)PenguinContetnView{
    if (!_PenguinContetnView) {
        _PenguinContetnView = [UIView new];
        _PenguinContetnView.layer.cornerRadius = RealWidth(5);
        _PenguinContetnView.layer.masksToBounds = YES;
        _PenguinContetnView.backgroundColor = [UIColor clearColor];
    }
    return _PenguinContetnView;
}

- (UIImageView *)PenguinThubImgView{
    if (!_PenguinThubImgView) {
        _PenguinThubImgView  = [UIImageView new];
        _PenguinThubImgView.contentMode = UIViewContentModeScaleAspectFill;
        _PenguinThubImgView.layer.masksToBounds = YES;
        _PenguinThubImgView.layer.cornerRadius = RealWidth(5);
    }
    return _PenguinThubImgView;
}
@end
