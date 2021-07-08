#import "PenguinhaseSendZoneCollectionCell.h"

@implementation PenguinhaseSendZoneCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView * PeuinChaseImgViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, K(100), K(100))];
        PeuinChaseImgViewIcon.layer.cornerRadius = K(5);
        PeuinChaseImgViewIcon.layer.masksToBounds = YES;
        [self.contentView addSubview:PeuinChaseImgViewIcon];
        _PeuinChaseImgViewIcon = PeuinChaseImgViewIcon;
    }
    return self;
}
@end
