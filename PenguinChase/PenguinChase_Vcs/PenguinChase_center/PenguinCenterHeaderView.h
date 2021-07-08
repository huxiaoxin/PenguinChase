//
//  PenguinCenterHeaderView.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import <UIKit/UIKit.h>
#import "PenguinCenterBtn.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PenguinCenterHeaderViewDelegate <NSObject>

-(void)PenguinCenterHeaderViewWithBtnClickIndex:(NSInteger)btnIndex;
-(void)PenguinCenterHeaderViewWithInfoAcion;
@end
@interface PenguinCenterHeaderView : UIView
@property(nonatomic,weak) id <PenguinCenterHeaderViewDelegate>delegate;
@property(nonatomic,strong)PenguinCenterBtn  * MyFolwwbtn;
@property(nonatomic,strong)PenguinCenterBtn  * MyWatchBtn;
@property(nonatomic,strong)PenguinCenterBtn  * MySendbtn;
@property(nonatomic,strong)PenguinCenterBtn  * MyColltecdbtn;
@property(nonatomic,strong) UIImageView * PenguinuserimgView;
@property(nonatomic,strong) UILabel     * PenguinNamelb;
@end

NS_ASSUME_NONNULL_END
