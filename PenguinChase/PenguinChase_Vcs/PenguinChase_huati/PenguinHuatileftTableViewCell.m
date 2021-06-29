//
//  PenguinHuatileftTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import "PenguinHuatileftTableViewCell.h"
@interface PenguinHuatileftTableViewCell ()
@property(nonatomic,strong) UIView * PenguinIndictorView;
@property(nonatomic,strong) UILabel * Penguinlb;
@end
@implementation PenguinHuatileftTableViewCell
-(void)PenguinChaseAddSubViews{
    [self addSubview:self.PenguinIndictorView];
    [self addSubview:self.Penguinlb];
    [_PenguinIndictorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.inset(RealWidth(3));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(RealWidth(2), RealWidth(10)));
    }];
    [_Penguinlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
}
- (UIView *)PenguinIndictorView{
    if (!_PenguinIndictorView) {
        _PenguinIndictorView = [UIView new];
        _PenguinIndictorView.backgroundColor = LGDBLackColor;
    }
    return _PenguinIndictorView;
}
- (UILabel *)Penguinlb{
    if (!_Penguinlb) {
        _Penguinlb = [UILabel new];
        _Penguinlb.textColor = LGDBLackColor;
        _Penguinlb.font = [UIFont boldSystemFontOfSize:12];
        _Penguinlb.text = @"本周推荐";
    }
    return _Penguinlb;
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
