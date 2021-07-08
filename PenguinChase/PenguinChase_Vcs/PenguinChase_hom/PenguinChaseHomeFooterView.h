//
//  PenguinChaseHomeFooterView.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PenguinChaseHomeFooterViewHeightBlock)(CGFloat FooterHeight);
@protocol PenguinChaseHomeFooterViewDelegate <NSObject>

-(void)PenguinChaseHomeFooterViewWithColltecDidSeltecd:(PenguinChaseVideoModel * )pengModel;

@end
@interface PenguinChaseHomeFooterView : UIView
@property(nonatomic,copy) PenguinChaseHomeFooterViewHeightBlock  FooterBlock;
@property(nonatomic,copy) NSArray * PenguinFooterDataArr;
@property(nonatomic,weak) id <PenguinChaseHomeFooterViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
