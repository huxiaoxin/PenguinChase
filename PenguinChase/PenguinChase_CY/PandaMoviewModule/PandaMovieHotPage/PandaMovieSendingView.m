//
//  PandaMovieSendingView.m
//  PandaMovie
//
//  Created by zjlk03 on 2021/5/31.
//

#import "PandaMovieSendingView.h"

@implementation PandaMovieSendingView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.image = [UIImage imageNamed:@"pandasend_huojian_icon"];
        self.backgroundColor = [UIColor clearColor];
        self.isKeepBounds = YES;
        self.freeRect = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_STATUSBAR_NAVBAR_HEIGHT-GK_TABBAR_HEIGHT);
    }
    return self;
}
@end
