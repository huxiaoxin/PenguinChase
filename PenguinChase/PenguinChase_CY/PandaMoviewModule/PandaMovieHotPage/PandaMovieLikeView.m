
#import "PandaMovieLikeView.h"

@interface PandaMovieLikeView()

@property (nonatomic, strong) UIImageView   *PandaMovielikeBeforeImgView;
@property (nonatomic, strong) UIImageView   *PandaMovielikeAfterImgView;

@property (nonatomic, strong) UILabel       *PandaMoviecountLabel;

@end

@implementation PandaMovieLikeView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.PandaMovielikeBeforeImgView];
        [self addSubview:self.PandaMovielikeAfterImgView];
        [self addSubview:self.PandaMoviecountLabel];
        
        self.PandaMovielikeBeforeImgView.frame = CGRectMake(0, 0, 24, 24);
        self.PandaMovielikeAfterImgView.frame  = CGRectMake(0, 0, 24, 24);
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint imgCenter = self.PandaMovielikeBeforeImgView.center;
    imgCenter.x = self.frame.size.width / 2;
    self.PandaMovielikeBeforeImgView.center = imgCenter;
    self.PandaMovielikeAfterImgView.center  = imgCenter;
    
    [self.PandaMoviecountLabel sizeToFit];
    
    CGFloat countX = (self.frame.size.width - self.PandaMoviecountLabel.frame.size.width) / 2;
    CGFloat countY = self.frame.size.height - self.PandaMoviecountLabel.frame.size.height;
    self.PandaMoviecountLabel.frame = CGRectMake(countX, countY, self.PandaMoviecountLabel.frame.size.width, self.PandaMoviecountLabel.frame.size.height);
}

- (void)PandaMoviesetupLikeState:(BOOL)isLike {
    self.isLike = isLike;
    
    if (isLike) {
        self.PandaMovielikeAfterImgView.hidden = NO;
    }else {
        self.PandaMovielikeAfterImgView.hidden = YES;
    }
}

- (void)PanDaMoviesetupLikeCount:(NSString *)count {
    self.PandaMoviecountLabel.text = count;
    
    [self layoutSubviews];
}

- (void)PandaMoviestartAnimationWithIsLike:(BOOL)isLike {
    if (self.isLike == isLike) return;
    
    self.isLike = isLike;
    
    if (isLike) {
        CGFloat length      = 30;
        CGFloat duration    = 0.5f;
        for (NSInteger i = 0; i < 6; i++) {
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.position = self.PandaMovielikeBeforeImgView.center;
            layer.fillColor = RGBA_COLOR(232, 50, 85, 1.0).CGColor;

            UIBezierPath *startPath = [UIBezierPath bezierPath];
            [startPath moveToPoint:CGPointMake(-2, -length)];
            [startPath addLineToPoint:CGPointMake(2, -length)];
            [startPath addLineToPoint:CGPointMake(0, 0)];
            layer.path = startPath.CGPath;

            layer.transform = CATransform3DMakeRotation(M_PI / 3.0f * i, 0, 0, 1.0);
            [self.layer addSublayer:layer];

            CAAnimationGroup *group = [CAAnimationGroup animation];
            group.removedOnCompletion = NO;
            group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            group.fillMode = kCAFillModeForwards;
            group.duration = duration;

            CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnim.fromValue = @(0.0f);
            scaleAnim.toValue = @(1.0f);
            scaleAnim.duration = duration * 0.2f;

            UIBezierPath *endPath = [UIBezierPath bezierPath];
            [endPath moveToPoint:CGPointMake(-2, -length)];
            [endPath addLineToPoint:CGPointMake(2, -length)];
            [endPath addLineToPoint:CGPointMake(0, -length)];

            CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnim.fromValue = (__bridge id)layer.path;
            pathAnim.toValue = (__bridge id)endPath.CGPath;
            pathAnim.beginTime = duration * 0.2f;
            pathAnim.duration = duration * 0.8f;

            [group setAnimations:@[scaleAnim, pathAnim]];
            [layer addAnimation:group forKey:nil];
        }
        self.PandaMovielikeAfterImgView.hidden = NO;
        self.PandaMovielikeAfterImgView.alpha = 0.0f;
        
        self.PandaMovielikeAfterImgView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
        [UIView animateWithDuration:0.15 animations:^{
            self.PandaMovielikeAfterImgView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            self.PandaMovielikeAfterImgView.alpha = 1.0f;
            self.PandaMovielikeBeforeImgView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.PandaMovielikeAfterImgView.transform = CGAffineTransformIdentity;
            self.PandaMovielikeBeforeImgView.alpha = 1.0f;
        }];
    }else {
        self.PandaMovielikeAfterImgView.alpha = 1.0f;
        self.PandaMovielikeAfterImgView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        [UIView animateWithDuration:0.15 animations:^{
            self.PandaMovielikeAfterImgView.transform = CGAffineTransformMakeScale(0.3f, 0.3f);
        } completion:^(BOOL finished) {
            self.PandaMovielikeAfterImgView.transform = CGAffineTransformIdentity;
            self.PandaMovielikeAfterImgView.hidden = YES;
        }];
    }
}

#pragma mark - UITapGestureRecognizer
- (void)tapAction:(UITapGestureRecognizer *)tap {
//    if (self.isLike) {
//        [self startAnimationWithIsLike:NO];
//    } else {
//        [self startAnimationWithIsLike:YES];
//    }
    
    if (self.pandalikeViewAction) {
        self.pandalikeViewAction(self.isLike);
    }
}

#pragma mark - 懒加载
- (UIImageView *)PandaMovielikeBeforeImgView {
    if (!_PandaMovielikeBeforeImgView) {
        _PandaMovielikeBeforeImgView = [UIImageView new];
        _PandaMovielikeBeforeImgView.image = [UIImage imageNamed:@"pandaMoview_zan_nomal"];
    }
    return _PandaMovielikeBeforeImgView;
}

- (UIImageView *)PandaMovielikeAfterImgView {
    if (!_PandaMovielikeAfterImgView) {
        _PandaMovielikeAfterImgView = [UIImageView new];
        _PandaMovielikeAfterImgView.image = [UIImage imageNamed:@"pandaMoview_zan_sel"];
    }
    return _PandaMovielikeAfterImgView;
}

- (UILabel *)PandaMoviecountLabel {
    if (!_PandaMoviecountLabel) {
        _PandaMoviecountLabel = [UILabel new];
        _PandaMoviecountLabel.textColor = [UIColor whiteColor];
        _PandaMoviecountLabel.font = zy_mediumSystemFont13;
    }
    return _PandaMoviecountLabel;
}

@end
