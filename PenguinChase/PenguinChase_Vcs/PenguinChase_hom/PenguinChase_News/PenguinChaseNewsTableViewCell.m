//
//  PenguinChaseNewsTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/30.
//

#import "PenguinChaseNewsTableViewCell.h"
@interface PenguinChaseNewsTableViewCell ()
@property(nonatomic,strong) UIView * penguinContentView;
@property(nonatomic,strong) UILabel * PenguinTitle;
@property(nonatomic,strong) UILabel * penguinMessagelb;
@property(nonatomic,strong) UIImageView * penguinThubImgView;

@end
@implementation PenguinChaseNewsTableViewCell

- (void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.penguinContentView];
    [_penguinContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(RealWidth(10), RealWidth(10), RealWidth(10), RealWidth(10)));
    }];
    
    [_penguinContentView addSubview:self.PenguinTitle];
    [_penguinContentView addSubview:self.penguinMessagelb];
    [_penguinContentView addSubview:self.penguinThubImgView];
 
    [_PenguinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(RealWidth(16));
        make.right.mas_equalTo(-RealWidth(120));
    }];
    
    [_penguinThubImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.inset(RealWidth(15));
        make.size.mas_equalTo(CGSizeMake(RealWidth(100), RealWidth(80)));
    }];
    
    [_penguinMessagelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RealWidth(15));
        make.bottom.mas_equalTo(-RealWidth(18));
    }];
    
}
- (UIView *)penguinContentView{
    if (!_penguinContentView) {
        _penguinContentView = [UIView new];
        _penguinContentView.layer.cornerRadius = RealWidth(5);
        _penguinContentView.layer.masksToBounds = YES;
        _penguinContentView.backgroundColor = [UIColor whiteColor];
    }
    return _penguinContentView;
}
- (UILabel *)PenguinTitle{
    if (!_PenguinTitle) {
        _PenguinTitle = [UILabel new];
        _PenguinTitle.numberOfLines  =2;
        _PenguinTitle.textColor = LGDBLackColor;
        _PenguinTitle.font = [UIFont boldSystemFontOfSize:15];
        _PenguinTitle.text = @"三流的父母给还在买房子，二流的父母把钱存到银行";
    }
    return _PenguinTitle;
}
- (UIImageView *)penguinThubImgView{
    if (!_penguinThubImgView) {
        _penguinThubImgView = [UIImageView new];
        _penguinThubImgView.contentMode = UIViewContentModeScaleAspectFill;
        _penguinThubImgView.layer.masksToBounds = YES;
        _penguinThubImgView.layer.cornerRadius =RealWidth(5);
    }
    return _penguinThubImgView;
}
- (UILabel *)penguinMessagelb{
    if (!_penguinMessagelb) {
        _penguinMessagelb = [UILabel new];
        _penguinMessagelb.textColor = LGDBLackColor;
        _penguinMessagelb.font = [UIFont boldSystemFontOfSize:12];
//        _penguinMessagelb.text = @"三流的父母给还在买房子，二流的父母把钱存到银行";
        
//        NSString  * penguinFirstText = @"701阅读 104分享  ";
//        NSString  * penguinSecondText = @"#理念";
//        NSMutableAttributedString * muatbute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",penguinFirstText,penguinSecondText]];
//        [muatbute addAttribute:NSForegroundColorAttributeName value:LGDLightBLackColor range:NSMakeRange(0, penguinFirstText.length)];
//        [muatbute addAttribute:NSForegroundColorAttributeName value:LGDMianColor range:NSMakeRange(penguinFirstText.length, penguinSecondText.length)];
//
//        _penguinMessagelb.attributedText = muatbute;
    }
    return _penguinMessagelb;
}
- (void)setPengModel:(PenguinChaseNewsModel *)pengModel{
    _pengModel = pengModel;
    _PenguinTitle.text = pengModel.title;
    NSString  * penguinFirstText = [NSString stringWithFormat:@"%@ ",pengModel.time];
    NSString  * penguinSecondText = [NSString stringWithFormat:@"#%@",pengModel.src];
    NSMutableAttributedString * muatbute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",penguinFirstText,penguinSecondText]];
    [muatbute addAttribute:NSForegroundColorAttributeName value:LGDLightBLackColor range:NSMakeRange(0, penguinFirstText.length)];
    [muatbute addAttribute:NSForegroundColorAttributeName value:LGDMianColor range:NSMakeRange(penguinFirstText.length, penguinSecondText.length)];
    _penguinMessagelb.attributedText = muatbute;
    [_penguinThubImgView sd_setImageWithURL:[NSURL URLWithString:pengModel.imgUrl] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];

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
