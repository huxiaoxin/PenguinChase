//
//  PenguinChasesystemMessageTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/30.
//

#import "PenguinChasesystemMessageTableViewCell.h"
@interface PenguinChasesystemMessageTableViewCell ()
@property(nonatomic,strong) UIImageView * penguinChaseIconImgView;
@property(nonatomic,strong) UILabel     * PenguinTitlelb;
@property(nonatomic,strong) UILabel     * PenguinRedNumslb;
@property(nonatomic,strong) UIView      * penguinBtomline;
@end
@implementation PenguinChasesystemMessageTableViewCell

-(void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.penguinChaseIconImgView];
    [self.contentView addSubview:self.PenguinTitlelb];
    [self.contentView addSubview:self.PenguinRedNumslb];
    [self.contentView addSubview:self.penguinBtomline];
    
    [_penguinChaseIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RealWidth(10));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(RealWidth(38), RealWidth(38)));
    }];
    [_PenguinTitlelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_penguinChaseIconImgView.mas_right).offset(RealWidth(10));
    }];
    [_penguinBtomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_penguinChaseIconImgView.mas_right).offset(RealWidth(10));
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-RealWidth(15));
        make.height.mas_equalTo(1);
    }];
    [_PenguinRedNumslb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-RealWidth(15));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(RealWidth(15), RealWidth(15)));
    }];
    
}
- (void)setPenguinMessageModel:(PenguinsystemMessageModel *)penguinMessageModel{
    _penguinMessageModel = penguinMessageModel;
    _penguinChaseIconImgView.image = [UIImage imageNamed:penguinMessageModel.img];
    _PenguinTitlelb.text = penguinMessageModel.Name;
    _PenguinRedNumslb.text  =penguinMessageModel.messageNums;
    _PenguinRedNumslb.hidden =  ![penguinMessageModel.messageNums integerValue];
    if ([penguinMessageModel.Name isEqual:@"系统消息"]) {
        _penguinChaseIconImgView.layer.cornerRadius  = RealWidth(19);
        
        [_penguinChaseIconImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RealWidth(38), RealWidth(38)));
        }];
    } else if ([penguinMessageModel.Name isEqual:@"在线客服"]){
        _penguinChaseIconImgView.layer.cornerRadius  = RealWidth(19);
        
        [_penguinChaseIconImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RealWidth(38), RealWidth(38)));
        }];
    }else{
        _penguinChaseIconImgView.layer.cornerRadius  = RealWidth(20);

        [_penguinChaseIconImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RealWidth(40), RealWidth(40)));
        }];
    }
    
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
- (UIImageView *)penguinChaseIconImgView{
    if (!_penguinChaseIconImgView) {
        _penguinChaseIconImgView = [UIImageView new];
        _penguinChaseIconImgView.layer.cornerRadius = RealWidth(19);
        _penguinChaseIconImgView.layer.masksToBounds = YES;
//        _penguinChaseIconImgView.backgroundColor = LGDMianColor;
    }
    return _penguinChaseIconImgView;
}
- (UILabel *)PenguinTitlelb{
    if (!_PenguinTitlelb) {
        _PenguinTitlelb = [UILabel new];
        _PenguinTitlelb.textColor = LGDLightBLackColor;
        _PenguinTitlelb.font =[UIFont boldSystemFontOfSize:16];
        _PenguinTitlelb.text = @"赞";
    }
    return _PenguinTitlelb;
}
- (UIView *)penguinBtomline{
    if (!_penguinBtomline) {
        _penguinBtomline = [UIView new];
        _penguinBtomline.backgroundColor = LGDLightGaryColor;
    }
    return _penguinBtomline;
}
@end
