//
//  PenguinChaseLoginTool.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChaseLoginTool.h"

@implementation PenguinChaseLoginTool
+(BOOL)PenguinChaseLoginToolCheckuserIslgoin{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"PenguinLoginStatus"];
    return isLogin;
}
+(NSString *)PenguinChasegetName{
    NSString * penguinText = [[NSUserDefaults standardUserDefaults] objectForKey:@"penguinName"];
    if (penguinText.length == 0) {
        return @"阿三的小蝴蝶";
    }else{
        return penguinText;
    }

}
@end
