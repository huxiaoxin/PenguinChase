//
//  UITitleView.m
//  ZhangYuSports
//
//  Created by bingbai on 2019/11/13.
//  Copyright © 2019 ChenYuan. All rights reserved.
//

#import "UITitleView.h"

@interface UITitleView ()

@property (nonatomic, assign) NSInteger itemWidth;
@property UIView *lineView;

@end

@implementation UITitleView
{
    NSMutableArray *titleLabelArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        titleLabelArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
-(void)setTitleArray:(NSArray *)titleArray{
    if (titleArray) {
        self.itemWidth = kScreenWidth / titleArray.count;
        for (int i=0;i<titleArray.count;i++) {
            NSString *title = [titleArray mdf_safeObjectAtIndex:i];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*self.itemWidth, 0, self.itemWidth, 44)];
            [titleLabel setBackgroundColor:[UIColor clearColor]];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
            titleLabel.text = title;
            titleLabel.userInteractionEnabled = YES;
            titleLabel.tag = i;
            [titleLabelArray addObject:titleLabel];
            [self addSubview:titleLabel];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(0, 0, 100, 44)];
            [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i+10;
            [titleLabel addSubview:button];
        }
        [self setFrame:CGRectMake(0, 0, titleArray.count*self.itemWidth, 44)];
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 60, 3)];
        self.lineView.backgroundColor = gnh_color_theme;
        self.lineView.layer.cornerRadius = 1.5f;
        self.lineView.layer.masksToBounds = YES;
        [self addSubview:self.lineView];
        
//        [self setupLineViewGradientLayer];
    }
}

- (void)setupLineViewGradientLayer
{
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.lineView.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.lineView.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)gnh_color_theme.CGColor,
                             (__bridge id)UIColor.whiteColor.CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.5f), @(1.0f)];
}

- (void)titleClick:(UIButton *)button
{
    if (self.titleCallBack) {
        [self scrollToTag:(button.tag-10)];
        self.titleCallBack(button.tag-10);
    }
}

- (void)setDefaultIndex:(NSInteger)defaultIndex
{
    if (defaultIndex>=titleLabelArray.count) {
        defaultIndex = 0;
    }
    _currentIndex = defaultIndex;
    [self.lineView setFrame:CGRectMake(defaultIndex*self.itemWidth+20, 40, 60, 3)];
    [titleLabelArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag==defaultIndex) {
            [obj setTextColor:UIColor.blackColor];
            obj.font = zy_blodFontSize18;
        }else{
            [obj setTextColor:RGBA_HexCOLOR(0x767676, 1)];
            obj.font = zy_blodFontSize15;
        }
    }];
}

- (void)scrollToTag:(NSInteger)index
{
    _currentIndex = index;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf.lineView setFrame:CGRectMake(index*self.itemWidth+20, 40, 60, 3)];
    }];
    [titleLabelArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag==index) {
            [obj setTextColor:UIColor.blackColor];
            obj.font = zy_blodFontSize18;
        }else{
            [obj setTextColor:RGBA_HexCOLOR(0x767676, 1)];
            obj.font = zy_blodFontSize15;
        }
    }];
}

@end

