//
//  PenguinChaseMessageTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/30.
//

#import "PenguinChaseMessageTableViewCell.h"
@interface  PenguinChaseMessageTableViewCell ()

@property(nonatomic,strong) UIImageView * PenguinMessageThubImgIcon;
@property(nonatomic,strong) UILabel     * PenguinMessageToplb;
@property(nonatomic,strong) UILabel     * PenguinMessageBtomlb;
@property(nonatomic,strong) UILabel     * PenguinMessageTimelb;
@property(nonatomic,strong) UILabel     * PenguinRedNumslb;
@property(nonatomic,strong) UIView      * penguinBtomline;
@end
@implementation PenguinChaseMessageTableViewCell
-(void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.PenguinMessageThubImgIcon];
    [self.contentView addSubview:self.PenguinMessageToplb];
    [self.contentView addSubview:self.PenguinMessageBtomlb];
    [self.contentView addSubview:self.PenguinMessageTimelb];
    [self.contentView addSubview:self.PenguinRedNumslb];
    [self.contentView addSubview:self.penguinBtomline];
    [_PenguinMessageThubImgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RealWidth(10));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(RealWidth(40), RealWidth(40)));
    }];
    
    [_PenguinMessageToplb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(RealWidth(16));
        make.left.mas_equalTo(_PenguinMessageThubImgIcon.mas_right).offset(RealWidth(10));
    }];
    
    [_PenguinMessageBtomlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_PenguinMessageToplb.mas_bottom).offset(RealWidth(2));
        make.left.mas_equalTo(_PenguinMessageThubImgIcon.mas_right).offset(RealWidth(10));
    }];
    
    [_penguinBtomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinMessageThubImgIcon.mas_right).offset(RealWidth(10));
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-RealWidth(15));
        make.height.mas_equalTo(1);
    }];
    [_PenguinMessageTimelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-RealWidth(15));
        make.top.mas_equalTo(RealWidth(16));
    }];
    [_PenguinRedNumslb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-RealWidth(15));
        make.top.mas_equalTo(_PenguinMessageTimelb.mas_bottom).offset(RealWidth(4));
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(RealWidth(15), RealWidth(15)));
    }];
    
}
- (UILabel *)PenguinMessageTimelb{
    if (!_PenguinMessageTimelb) {
        _PenguinMessageTimelb  = [UILabel new];
        _PenguinMessageTimelb.textColor = LGDLightBLackColor;
        _PenguinMessageTimelb.font = [UIFont boldSystemFontOfSize:10];
        _PenguinMessageTimelb.text = @"12:02";
    }
    return _PenguinMessageTimelb;
}
- (UIImageView *)PenguinMessageThubImgIcon{
    if (!_PenguinMessageThubImgIcon) {
        _PenguinMessageThubImgIcon = [UIImageView new];
        _PenguinMessageThubImgIcon.backgroundColor = LGDMianColor;
        _PenguinMessageThubImgIcon.layer.cornerRadius = RealWidth(20);
        _PenguinMessageThubImgIcon.layer.masksToBounds = YES;
    }
    return _PenguinMessageThubImgIcon;
}
- (UILabel *)PenguinMessageToplb{
    if (!_PenguinMessageToplb) {
        _PenguinMessageToplb = [UILabel new];
        _PenguinMessageToplb.textColor = LGDBLackColor;
        _PenguinMessageToplb.font =  [UIFont boldSystemFontOfSize:15];
        _PenguinMessageToplb.text  = @"评论";
    }
    return _PenguinMessageToplb;
}
- (UILabel *)PenguinMessageBtomlb{
    if (!_PenguinMessageBtomlb) {
        _PenguinMessageBtomlb = [UILabel new];
        _PenguinMessageBtomlb.textColor = LGDLightBLackColor;
        _PenguinMessageBtomlb.font =  [UIFont boldSystemFontOfSize:10];
        _PenguinMessageBtomlb.text  = @"请登录后查看消息";
    }
    return _PenguinMessageBtomlb;
}
- (UIView *)penguinBtomline{
    if (!_penguinBtomline) {
        _penguinBtomline = [UIView new];
        _penguinBtomline.backgroundColor = LGDLightGaryColor;
    }
    return _penguinBtomline;
}
- (UILabel *)PenguinRedNumslb{
    if (!_PenguinRedNumslb) {
        _PenguinRedNumslb = [UILabel new];
        _PenguinRedNumslb.text = @"12";
        _PenguinRedNumslb.textAlignment = NSTextAlignmentCenter;
        _PenguinRedNumslb.font = [UIFont systemFontOfSize:10];
        _PenguinRedNumslb.textColor = [UIColor whiteColor];
        _PenguinRedNumslb.backgroundColor = LGDRedColor;
        _PenguinRedNumslb.layer.cornerRadius =RealWidth(7.5);
        _PenguinRedNumslb.layer.masksToBounds = YES;
    }
    return _PenguinRedNumslb;
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
