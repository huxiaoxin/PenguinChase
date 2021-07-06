#import "PenguinhaseSendZoneCollectionCell.h"

@implementation PenguinhaseSendZoneCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView * FilmFactoryImgViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, K(100), K(100))];
        FilmFactoryImgViewIcon.layer.cornerRadius = K(5);
        FilmFactoryImgViewIcon.layer.masksToBounds = YES;
        [self.contentView addSubview:FilmFactoryImgViewIcon];
        _PeuinChaseImgViewIcon = FilmFactoryImgViewIcon;
    }
    return self;
}
@end
