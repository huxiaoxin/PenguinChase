#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PenguinChaseCollectionCellDelegate <NSObject>

-(void)PenguinChaseCollectionCellDelegateWithBtnCliocks:(NSInteger)SanXindex;

@end
@interface PenguinChaseAdviceCollectionCell : UICollectionViewCell
@property(nonatomic,strong) UIImage * penguinimmgs;
@property(nonatomic,strong) UIImageView * pengiinImgViews;

@property(nonatomic,weak) id <PenguinChaseCollectionCellDelegate>Delegate;
@end

NS_ASSUME_NONNULL_END
