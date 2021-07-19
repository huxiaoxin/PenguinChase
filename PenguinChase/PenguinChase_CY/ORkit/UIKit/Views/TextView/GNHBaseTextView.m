//
//  GNHBaseTextView.m
//  GeiNiHua
//
//  Created by sanshao on 2017/5/15.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHBaseTextView.h"

@interface GNHBaseTextView()<UITextViewDelegate>
@property (nonatomic, copy) GNHBaseTextViewDidClickBlock didClickBlock;

@end

@implementation GNHBaseTextView

+ (instancetype)textViewWithText:(NSString *)text
                   didClickBlock:(GNHBaseTextViewDidClickBlock)didClickBlock
{
    GNHBaseTextView *tv = [GNHBaseTextView ly_TextViewWithText:text font:nil textColor:nil delegate:nil];
    tv.didClickBlock = [didClickBlock copy];
    return tv;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"%@",URL);
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (self.isHiddenEditMenu) {
        if ([UIMenuController sharedMenuController])
        {
            [UIMenuController   sharedMenuController].menuVisible = NO;
        }
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end
