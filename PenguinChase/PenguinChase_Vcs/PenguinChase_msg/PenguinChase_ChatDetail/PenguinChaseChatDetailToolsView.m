
#import "PenguinChaseChatDetailToolsView.h"
#import <UITextView+ZWPlaceHolder.h>
@interface PenguinChaseChatDetailToolsView ()
@property(nonatomic,strong) UITextView * textView;
@property(nonatomic,strong) UIButton * sednBtn;
@property(nonatomic,copy) sendToolBlock sendBlock;
@end
@implementation PenguinChaseChatDetailToolsView
-(instancetype)initWithFrame:(CGRect)frame witheTextViewBlokc:(sendToolBlock)toolblokc{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.sendBlock = toolblokc;
        [self addSubview:self.textView];
        [self addSubview:self.sednBtn];
    }
    return self;
}
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectZero];
        _textView.zw_placeHolder = @"说点什么吧～";
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textColor = [UIColor whiteColor];
        _textView.layer.borderColor = [UIColor colorWithHexString:@"cdcdcd"].CGColor;
        _textView.layer.borderWidth = RealWidth(1);
        _textView.layer.cornerRadius  =RealWidth(4);
        _textView.layer.masksToBounds = YES;
        _textView.textColor = [UIColor blackColor];
    }
    return _textView;
}
-(UIButton *)sednBtn{
    if (!_sednBtn) {
        _sednBtn = [[UIButton alloc]init];
        [_sednBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sednBtn setBackgroundColor:LGDMianColor];
        _sednBtn.layer.cornerRadius = RealWidth(5);
        _sednBtn.layer.masksToBounds = YES;
        _sednBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _sednBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_sednBtn addTarget:self action:@selector(sednBtnClcki) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sednBtn;
}
-(void)layoutSubviews{
    _textView.frame = CGRectMake(RealWidth(20), RealWidth(15), SCREEN_Width-RealWidth(40+70), RealWidth(40));
    _sednBtn.frame = CGRectMake(CGRectGetMaxX(_textView.frame)+RealWidth(10), RealWidth(15), RealWidth(60), RealWidth(40));
}
-(void)sednBtnClcki{
    if (self.textView.text.length > 0) {
        if (self.sendBlock) {
            self.sendBlock(self.textView);
        }
    }
}
@end
