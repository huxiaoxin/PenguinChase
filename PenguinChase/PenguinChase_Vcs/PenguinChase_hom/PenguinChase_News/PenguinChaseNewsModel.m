//
//  PenguinChaseNewsModel.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/8.
//

#import "PenguinChaseNewsModel.h"

@implementation PenguinChaseNewsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"pic"]) {
        self.imgUrl = value;
    }
}
@end
