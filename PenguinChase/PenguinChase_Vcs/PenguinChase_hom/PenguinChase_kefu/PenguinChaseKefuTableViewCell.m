
#import "PenguinChaseKefuTableViewCell.h"
@interface PenguinChaseKefuTableViewCell ()
@property(nonatomic,strong) UIImageView * PenguinChaseChatSEND_paopaoImgView;
@property(nonatomic,strong) UIImageView * PenguinChaseChatSEND_userImgView;
@property(nonatomic,strong) UILabel * PenguinChaseChatSEND_Contentlb;
@property(nonatomic,strong) UIImage * PenguinChaseChatSEND_uiimageName;


@property(nonatomic,strong) UIImageView * PenguinChaseChatReVICE_paopaoIMgView;
@property(nonatomic,strong) UIImageView * PenguinChaseChatReVICE_userImgView;
@property(nonatomic,strong) UILabel * PenguinChaseChatReVICE_contelb;
@property(nonatomic,strong) UIImage * PenguinChaseChatReVICE_uiimaname;


@end
@implementation PenguinChaseKefuTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.PenguinChaseChatSEND_userImgView];
        [self addSubview:self.PenguinChaseChatSEND_paopaoImgView];
        [_PenguinChaseChatSEND_paopaoImgView addSubview:self.PenguinChaseChatSEND_Contentlb];
        
        [self.contentView addSubview:self.PenguinChaseChatReVICE_userImgView];
        [self addSubview:self.PenguinChaseChatReVICE_paopaoIMgView];
        [_PenguinChaseChatReVICE_paopaoIMgView addSubview:self.PenguinChaseChatReVICE_contelb];
    }
    return self;
}
-(UIImageView *)PenguinChaseChatReVICE_userImgView{
    if (!_PenguinChaseChatReVICE_userImgView) {
        _PenguinChaseChatReVICE_userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(RealWidth(15), RealWidth(17.5), RealWidth(35), RealWidth(35))];
        _PenguinChaseChatReVICE_userImgView.layer.cornerRadius = RealWidth(17.5);
        _PenguinChaseChatReVICE_userImgView.layer.masksToBounds = YES;
    }
    return _PenguinChaseChatReVICE_userImgView;
}
-(UIImageView *)PenguinChaseChatSEND_userImgView{
    if (!_PenguinChaseChatSEND_userImgView) {
        _PenguinChaseChatSEND_userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_Width-RealWidth(60), RealWidth(17.5), RealWidth(35), RealWidth(35))];
        _PenguinChaseChatSEND_userImgView.layer.cornerRadius = RealWidth(17.5);
        _PenguinChaseChatSEND_userImgView.layer.masksToBounds = YES;
    }
    return _PenguinChaseChatSEND_userImgView;
}

- (UIImageView *)PenguinChaseChatReVICE_paopaoIMgView{
    if (!_PenguinChaseChatReVICE_paopaoIMgView) {
        _PenguinChaseChatReVICE_paopaoIMgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PenguinChaseChatReVICE_userImgView.frame)+RealWidth(15), CGRectGetMidY(_PenguinChaseChatReVICE_userImgView.frame), 0, 0)];
        _PenguinChaseChatReVICE_paopaoIMgView.image = self.PenguinChaseChatReVICE_uiimaname;
    }
    return _PenguinChaseChatReVICE_paopaoIMgView;
}
- (UIImageView *)PenguinChaseChatSEND_paopaoImgView{
    if (!_PenguinChaseChatSEND_paopaoImgView) {
        _PenguinChaseChatSEND_paopaoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_Width-CGRectGetWidth(_PenguinChaseChatSEND_paopaoImgView.frame)-RealWidth(15)-RealWidth(170), CGRectGetMidY(_PenguinChaseChatSEND_userImgView.frame), RealWidth(160), RealWidth(30))];
        _PenguinChaseChatSEND_paopaoImgView.image = self.PenguinChaseChatSEND_uiimageName;
    }
    return _PenguinChaseChatSEND_paopaoImgView;
}
-(UILabel *)PenguinChaseChatReVICE_contelb{
    if (!_PenguinChaseChatReVICE_contelb) {
        _PenguinChaseChatReVICE_contelb = [[UILabel alloc]init];
        _PenguinChaseChatReVICE_contelb.numberOfLines = 0;
        _PenguinChaseChatReVICE_contelb.textColor = [UIColor whiteColor];
        _PenguinChaseChatReVICE_contelb.font = [UIFont systemFontOfSize:15];
    }
    return _PenguinChaseChatReVICE_contelb;
}
-(UILabel *)PenguinChaseChatSEND_Contentlb{
    if (!_PenguinChaseChatSEND_Contentlb) {
        _PenguinChaseChatSEND_Contentlb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _PenguinChaseChatSEND_Contentlb.numberOfLines = 0;
        _PenguinChaseChatSEND_Contentlb.textColor = [UIColor whiteColor];
        _PenguinChaseChatSEND_Contentlb.font = [UIFont systemFontOfSize:15];
    }
    return _PenguinChaseChatSEND_Contentlb;
}
- (UIImage *)PenguinChaseChatSEND_uiimageName {
    if (_PenguinChaseChatSEND_uiimageName == nil) {
        UIImage *image = [UIImage imageNamed:@"qipao_send"];
        CGSize size = image.size;
        _PenguinChaseChatSEND_uiimageName = [image stretchableImageWithLeftCapWidth:size.width/2 topCapHeight:size.height*0.8];
    }
    return _PenguinChaseChatSEND_uiimageName;
}
- (UIImage *)PenguinChaseChatReVICE_uiimaname{
    if (!_PenguinChaseChatReVICE_uiimaname) {
        UIImage *image  = [UIImage imageNamed:@"qipao_revice"];
        CGSize size = image.size;
        _PenguinChaseChatReVICE_uiimaname = [image stretchableImageWithLeftCapWidth:size.width/2 topCapHeight:size.height*0.8];
    }
    return _PenguinChaseChatReVICE_uiimaname;
}
-(void)setPenguinModel:(PenguinChaseKefuModel *)penguinModel{
    _penguinModel =  penguinModel;
    [_PenguinChaseChatSEND_userImgView sd_setImageWithURL:[NSURL URLWithString:@"https://img2.woyaogexing.com/2021/06/19/4e16cecbec4145c4b10e52bb0b50fd17!400x400.jpeg"]];
    _PenguinChaseChatReVICE_userImgView.image = [UIImage imageNamed:@"kefu_onine"];
    if (penguinModel.msgisMe) {
        _PenguinChaseChatReVICE_paopaoIMgView.hidden = YES;
        _PenguinChaseChatReVICE_userImgView.hidden = YES;
        _PenguinChaseChatReVICE_contelb.hidden = YES;
        
        _PenguinChaseChatSEND_paopaoImgView.hidden = NO;
        _PenguinChaseChatSEND_userImgView.hidden = NO;
        _PenguinChaseChatSEND_Contentlb.hidden = NO;
        
        [_PenguinChaseChatSEND_Contentlb setText:penguinModel.msgname];
        CGRect contetnRect =  [penguinModel.msgname cxl_sizeWithMoreString:[UIFont systemFontOfSize:15] maxWidth:SCREEN_Width-RealWidth(150)];
        
        _PenguinChaseChatSEND_Contentlb.frame = CGRectMake(RealWidth(10), RealWidth(10), contetnRect.size.width, contetnRect.size.height);
        
        _PenguinChaseChatSEND_paopaoImgView.frame = CGRectMake(SCREEN_Width-contetnRect.size.width-RealWidth(45+15+25), RealWidth(15), contetnRect.size.width+RealWidth(20), contetnRect.size.height+RealWidth(20));
        penguinModel.CellHeight =  CGRectGetMaxY(_PenguinChaseChatSEND_paopaoImgView.frame)+RealWidth(30);
        
    }else{
        
        _PenguinChaseChatReVICE_paopaoIMgView.hidden = NO;
        _PenguinChaseChatReVICE_userImgView.hidden = NO;
        _PenguinChaseChatReVICE_contelb.hidden = NO;
        
        _PenguinChaseChatSEND_paopaoImgView.hidden = YES;
        _PenguinChaseChatSEND_userImgView.hidden = YES;
        _PenguinChaseChatSEND_Contentlb.hidden = YES;
        
        
        [_PenguinChaseChatReVICE_contelb setText:penguinModel.msgname];
        CGRect contetnRect =  [penguinModel.msgname cxl_sizeWithMoreString:[UIFont systemFontOfSize:15] maxWidth:SCREEN_Width-RealWidth(150)];
        
        _PenguinChaseChatReVICE_contelb.frame = CGRectMake(RealWidth(20), RealWidth(10), contetnRect.size.width, contetnRect.size.height);
        
        _PenguinChaseChatReVICE_paopaoIMgView.frame = CGRectMake(CGRectGetMaxX(_PenguinChaseChatReVICE_userImgView.frame)+RealWidth(5), RealWidth(8), contetnRect.size.width+RealWidth(30), contetnRect.size.height+RealWidth(20));
        penguinModel.CellHeight =  CGRectGetMaxY(_PenguinChaseChatReVICE_paopaoIMgView.frame)+RealWidth(30);
        
    }
    
}
- (void)setPenguinDetailModel:(PenguinChaseMessageDetailModel *)penguinDetailModel{
    _penguinDetailModel = penguinDetailModel;
    [_PenguinChaseChatSEND_userImgView sd_setImageWithURL:[NSURL URLWithString:@"https://img2.woyaogexing.com/2021/06/19/4e16cecbec4145c4b10e52bb0b50fd17!400x400.jpeg"]];
    [_PenguinChaseChatReVICE_userImgView sd_setImageWithURL:[NSURL URLWithString:penguinDetailModel.imgUrl]];
    if (penguinDetailModel.msgisMe) {
        _PenguinChaseChatReVICE_paopaoIMgView.hidden = YES;
        _PenguinChaseChatReVICE_userImgView.hidden = YES;
        _PenguinChaseChatReVICE_contelb.hidden = YES;
        
        _PenguinChaseChatSEND_paopaoImgView.hidden = NO;
        _PenguinChaseChatSEND_userImgView.hidden = NO;
        _PenguinChaseChatSEND_Contentlb.hidden = NO;
        
        [_PenguinChaseChatSEND_Contentlb setText:penguinDetailModel.msgname];
        CGRect contetnRect =  [penguinDetailModel.msgname cxl_sizeWithMoreString:[UIFont systemFontOfSize:15] maxWidth:SCREEN_Width-RealWidth(150)];
        
        _PenguinChaseChatSEND_Contentlb.frame = CGRectMake(RealWidth(10), RealWidth(10), contetnRect.size.width, contetnRect.size.height);
        
        _PenguinChaseChatSEND_paopaoImgView.frame = CGRectMake(SCREEN_Width-contetnRect.size.width-RealWidth(45+15+25), RealWidth(15), contetnRect.size.width+RealWidth(20), contetnRect.size.height+RealWidth(20));
        penguinDetailModel.CellHeight =  CGRectGetMaxY(_PenguinChaseChatSEND_paopaoImgView.frame)+RealWidth(30);
        
    }else{
        
        _PenguinChaseChatReVICE_paopaoIMgView.hidden = NO;
        _PenguinChaseChatReVICE_userImgView.hidden = NO;
        _PenguinChaseChatReVICE_contelb.hidden = NO;
        
        _PenguinChaseChatSEND_paopaoImgView.hidden = YES;
        _PenguinChaseChatSEND_userImgView.hidden = YES;
        _PenguinChaseChatSEND_Contentlb.hidden = YES;
        
        
        [_PenguinChaseChatReVICE_contelb setText:penguinDetailModel.msgname];
        CGRect contetnRect =  [penguinDetailModel.msgname cxl_sizeWithMoreString:[UIFont systemFontOfSize:15] maxWidth:SCREEN_Width-RealWidth(150)];
        
        _PenguinChaseChatReVICE_contelb.frame = CGRectMake(RealWidth(20), RealWidth(10), contetnRect.size.width, contetnRect.size.height);
        
        _PenguinChaseChatReVICE_paopaoIMgView.frame = CGRectMake(CGRectGetMaxX(_PenguinChaseChatReVICE_userImgView.frame)+RealWidth(5), RealWidth(8), contetnRect.size.width+RealWidth(30), contetnRect.size.height+RealWidth(20));
        penguinDetailModel.CellHeight =  CGRectGetMaxY(_PenguinChaseChatReVICE_paopaoIMgView.frame)+RealWidth(30);
        
    }
}
@end


