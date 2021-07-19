//
//  UIAngleItemView.m
//  ZhangYuSports
//
//  Created by bingbai on 2019/11/23.
//  Copyright © 2019 ChenYuan. All rights reserved.
//

#import "UIAngleItemView.h"

@implementation UIAngleItemView


@synthesize countLa;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame=frame;
        self.backgroundColor=[UIColor clearColor];
        UIImage* bgImage=nil;
        if (frame.size.width==10) {
            bgImage=[UIImage imageNamed:@"s_message"];
        }
        else if(frame.size.width==18){
            bgImage=[UIImage imageNamed:@"m_message"];
        }
        else if(frame.size.width==28){
            UIEdgeInsets inset = UIEdgeInsetsMake(8.5f, 8.5f, 8.5f, 8.5f);
            bgImage=[[UIImage imageNamed:@"m_message"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
        }
        self.image=bgImage;
        
        if (frame.size.width!=10) {
            countLa=[[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,frame.size.width,frame.size.height)];
            countLa.backgroundColor=[UIColor clearColor];
            countLa.font=[UIFont fontWithName:@"Helvetica" size:10.0f];
            countLa.textAlignment = NSTextAlignmentCenter;
            countLa.textColor=[UIColor whiteColor];
            countLa.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            [self addSubview:countLa];
        }
    }
    return self;
}

-(void)toChangeAngleFrameWith:(CGRect)rect
{
    self.frame=rect;
    UIImage* bgImage=nil;
    if (rect.size.width==10) {
        bgImage=[UIImage imageNamed:@"s_message"];
    }
    else if(rect.size.width==18){
        bgImage=[UIImage imageNamed:@"m_message"];
    }
    else if(rect.size.width==28){
        UIEdgeInsets inset = UIEdgeInsetsMake(8.5f, 8.5f, 8.5f, 8.5f);
        bgImage=[[UIImage imageNamed:@"m_message"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    }
    self.image=bgImage;
    if (countLa) {
        countLa.frame=CGRectMake(0, 0 ,rect.size.width,rect.size.height);
    }
}

@end
