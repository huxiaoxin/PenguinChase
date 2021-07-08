//
//  PenguinHuatiRigthTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import "PenguinHuatiRigthTableViewCell.h"
@interface PenguinHuatiRigthTableViewCell ()
@property(nonatomic,strong) UIImageView * PenguinChaseThubImg;
@property(nonatomic,strong) UIView      * PenguinContentView;
@property(nonatomic,strong) UILabel     * PenguinTitle;
@property(nonatomic,strong) UILabel     * PenguinContentlb;
@end
@implementation PenguinHuatiRigthTableViewCell
-(void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.PenguinContentView];
    [self.contentView addSubview:self.PenguinChaseThubImg];
    [_PenguinContentView addSubview:self.PenguinTitle];
    [_PenguinContentView addSubview:self.PenguinContentlb];
    [_PenguinContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(RealWidth(45), RealWidth(15), RealWidth(10), RealWidth(15)));
    }];
    
    [_PenguinChaseThubImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinContentView.mas_left).offset(RealWidth(10));
        make.top.mas_equalTo(RealWidth(10));
        make.size.mas_equalTo(CGSizeMake(RealWidth(90), RealWidth(110)));
    }];
    [_PenguinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinChaseThubImg.mas_right).offset(RealWidth(8));
        make.top.mas_equalTo(RealWidth(15));
    }];
    [_PenguinContentlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinChaseThubImg.mas_right).offset(RealWidth(8));
        make.right.mas_equalTo(_PenguinContentView.mas_right).offset(-RealWidth(8));
        make.top.mas_equalTo(_PenguinTitle.mas_bottom).offset(RealWidth(5));
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [self->_PenguinContentView viewShadowPathWithColor:LGDGaryColor shadowOpacity:0.1 shadowRadius:RealWidth(5) shadowPathType:6 shadowPathWidth:RealWidth(5)];
    });
    

}
- (UIView *)PenguinContentView{
    if (!_PenguinContentView) {
        _PenguinContentView = [UIView new];
        _PenguinContentView.backgroundColor = [UIColor whiteColor];
        _PenguinContentView.layer.cornerRadius = RealWidth(5);
        
    }
    return _PenguinContentView;
}
-(UIImageView *)PenguinChaseThubImg{
    if (!_PenguinChaseThubImg) {
        _PenguinChaseThubImg = [UIImageView new];
        _PenguinChaseThubImg.layer.cornerRadius = RealWidth(5);
        _PenguinChaseThubImg.layer.masksToBounds = YES;
//        _PenguinChaseThubImg.backgroundColor = LGDMianColor;
        _PenguinChaseThubImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _PenguinChaseThubImg;
}
- (UILabel *)PenguinTitle{
    if (!_PenguinTitle) {
        _PenguinTitle = [UILabel new];
        _PenguinTitle.textColor = LGDBLackColor;
        _PenguinTitle.font = [UIFont boldSystemFontOfSize:15];
        _PenguinTitle.text = @"我的姐姐";
    }
    return _PenguinTitle;
}
- (UILabel *)PenguinContentlb{
    if (!_PenguinContentlb) {
        _PenguinContentlb = [UILabel new];
        _PenguinContentlb.textColor = LGDLightBLackColor;
        _PenguinContentlb.font = [UIFont systemFontOfSize:12];
        _PenguinContentlb.text = @"我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐我的姐姐";
        _PenguinContentlb.numberOfLines = 3;
    }
    return _PenguinContentlb;
}
- (void)setPengModel:(PenguinChaseVideoModel *)pengModel{
    _pengModel = pengModel;
    _PenguinTitle.text = pengModel.penguinChase_MoviewName;
    _PenguinContentlb.text = pengModel.penguinChase_MoviewDesc;
    [_PenguinChaseThubImg sd_setImageWithURL:[NSURL URLWithString:pengModel.penguinChase_MoviewIocnurl] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
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
