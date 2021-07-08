//
//  PenguinChaseBaseModel.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/8.
//

#import "PenguinChaseBaseModel.h"

@implementation PenguinChaseBaseModel
+(instancetype)BaseinitWithDic:(NSDictionary *)Dic;
{
    return [[self alloc]initWithDictionaryed:Dic];
}
-(instancetype)initWithDictionaryed:(NSDictionary *)dict
{
    if (self =[super init]) {
    [self setValuesForKeysWithDictionary:dict];
    
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
   
}
@end
