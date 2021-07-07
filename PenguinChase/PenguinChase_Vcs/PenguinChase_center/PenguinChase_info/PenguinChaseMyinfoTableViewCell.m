

#import "PenguinChaseMyinfoTableViewCell.h"
@interface PenguinChaseMyinfoTableViewCell ()
{
    UILabel * _PenguinChaseLeftLb;
}
@end
@implementation PenguinChaseMyinfoTableViewCell
-(void)PenguinChaseAddSubViews{
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    UILabel * PenguinChaseLeftLb = [UILabel new];
    PenguinChaseLeftLb.textColor = LGDBLackColor;
    PenguinChaseLeftLb.font = [UIFont systemFontOfSize:15];
    PenguinChaseLeftLb.text = @"头像";
    [self.contentView addSubview:PenguinChaseLeftLb];
    _PenguinChaseLeftLb = PenguinChaseLeftLb;
    
    
    [PenguinChaseLeftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(RealWidth(15));
    }];
    
    UIView * PenguinChaseline = [UIView new];
    PenguinChaseline.backgroundColor = LGDLightGaryColor;
    [self.contentView addSubview:PenguinChaseline];
    
    [PenguinChaseline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(.5);
    }];
    
    UIImageView * PenguinChaseRightImgView = [UIImageView new];
    PenguinChaseRightImgView.image = [UIImage imageNamed:@"youbian1x"];
    [self.contentView addSubview:PenguinChaseRightImgView];
    
    [PenguinChaseRightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(RealWidth(14), RealWidth(14)));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-RealWidth(10));
    }];
    
    UIImageView *PenguinChaseHeaderImgView = [UIImageView new];
    [PenguinChaseHeaderImgView sd_setImageWithURL:[NSURL URLWithString:@"https://img2.woyaogexing.com/2021/06/19/4e16cecbec4145c4b10e52bb0b50fd17!400x400.jpeg"] placeholderImage:[UIImage imageNamed:@"whiteLogo"]];
    PenguinChaseHeaderImgView.layer.cornerRadius = RealWidth(15);
    PenguinChaseHeaderImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:PenguinChaseHeaderImgView];
    self.PenguinChaseuserHeaderImgView =  PenguinChaseHeaderImgView;
    [PenguinChaseHeaderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(PenguinChaseRightImgView.mas_left).offset(-RealWidth(10));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(RealWidth(30), RealWidth(30)));
    }];
    
    UILabel * PenguinChaselb = [UILabel new];
    PenguinChaselb.font = [UIFont systemFontOfSize:13];
    PenguinChaselb.textColor = LGDBLackColor;
    PenguinChaselb.text = @"我的小日子";
    [self.contentView addSubview:PenguinChaselb];
    self.penguinChaseuserNamelb = PenguinChaselb;
    
    [PenguinChaselb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(PenguinChaseRightImgView.mas_right).offset(-RealWidth(12));
        make.centerY.mas_equalTo(self);
    }];
}
-(void)PenguinChaseMyinfoTableViewCellConfiguarWithIndexPath:(NSIndexPath * )indexPath{
    if (indexPath.row == 0) {
        _PenguinChaseLeftLb.text  = @"头像";
        self.penguinChaseuserNamelb.hidden = YES;
        self.PenguinChaseuserHeaderImgView.hidden  = NO;
        
    }else{
        self.PenguinChaseuserHeaderImgView.hidden = YES;
        self.penguinChaseuserNamelb.hidden = NO;
        _PenguinChaseLeftLb.text = @"昵称";
    }
    
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
