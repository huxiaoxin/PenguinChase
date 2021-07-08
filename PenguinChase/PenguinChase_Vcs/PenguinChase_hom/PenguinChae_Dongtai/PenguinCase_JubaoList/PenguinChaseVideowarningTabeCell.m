 
#import "PenguinChaseVideowarningTabeCell.h"
@interface PenguinChaseVideowarningTabeCell ()
{
    UILabel * _PenguinChaseContenlb;
    UIImageView * PengyiiNhaseVideoSecondlb;
}
@end
@implementation PenguinChaseVideowarningTabeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        UIView * PenguinChaseline = [[UIView alloc]initWithFrame:CGRectMake(K(15), K(49), SCREEN_Width-K(30), K(1))];
        PenguinChaseline.backgroundColor = LGDLightGaryColor;
        [self.contentView addSubview:PenguinChaseline];
        
        UILabel * PenguinChaseContenlb  = [[UILabel alloc]initWithFrame:CGRectMake(K(15), 0, K(200), K(49))];
        PenguinChaseContenlb.font =[UIFont systemFontOfSize:15];
        PenguinChaseContenlb.textColor = [UIColor blackColor];
        [self.contentView addSubview:PenguinChaseContenlb];
        _PenguinChaseContenlb = PenguinChaseContenlb;
        
        
        UIImageView * PengyiiNhaseVideoSecondlb  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_Width-K(35), K(15), K(20), K(20))];
        [self.contentView addSubview:PengyiiNhaseVideoSecondlb];
        PengyiiNhaseVideoSecondlb = PengyiiNhaseVideoSecondlb;
        
    }
    return self;
}
-(void)setPenguinModel:(PenguinChaseJubaoVideoWarningModel *)penguinModel{
    _penguinModel = penguinModel;
    _PenguinChaseContenlb.text = penguinModel.PenguinChaseVideoText;
    PengyiiNhaseVideoSecondlb.image = [UIImage imageNamed:penguinModel.PenguinChaseVideoStatus ? @"xuanzhong" : @"weixuanzhong"];
    
}
@end
