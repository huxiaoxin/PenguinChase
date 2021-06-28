//
//  WWStarView.h
//  Star
//
//  Created by 王威 on 2016/12/30.
//  Copyright © 2016年 皓天国博. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, StarStyle)
{
    WholeStar = 0, //只能整星评论
    HalfStar = 1,  //允许半星评论
    IncompleteStar = 2  //允许不完整星评论
};typedef void(^finishBlock)(CGFloat currentStar);
@class WWStarView;
@protocol WWStarViewDelegate <NSObject>

-(void)starEvaluator:(WWStarView *)star currentValue:(CGFloat)value;

@end
@interface WWStarView : UIView
@property(nonatomic,strong)NSString *amptyImageName;//未选中的星星的图片的名字
@property(nonatomic,strong)NSString *fullImageName;//选中的图片的颜色
@property (nonatomic,assign)CGFloat currentStar;   // 当前评分：0-5  默认0
@property (nonatomic,assign)BOOL isAnimation;       //是否动画显示，默认NO
@property (nonatomic,assign)StarStyle rateStyle;    //评分样式    默认是WholeStar
@property (nonatomic, assign) NSInteger numberOfStars;//有几个
@property (nonatomic, weak) id<WWStarViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars currentStar:(CGFloat)currentStar rateStyle:(StarStyle)rateStyle isAnination:(BOOL)isAnimation andamptyImageName:(NSString *)amptyImageName fullImageName:(NSString *)fullImageName finish:(finishBlock)finish;
@end
