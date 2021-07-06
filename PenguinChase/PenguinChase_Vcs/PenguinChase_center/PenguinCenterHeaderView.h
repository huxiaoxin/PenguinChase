//
//  PenguinCenterHeaderView.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PenguinCenterHeaderViewDelegate <NSObject>

-(void)PenguinCenterHeaderViewWithBtnClickIndex:(NSInteger)btnIndex;
-(void)PenguinCenterHeaderViewWithInfoAcion;
@end
@interface PenguinCenterHeaderView : UIView
@property(nonatomic,weak) id <PenguinCenterHeaderViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
