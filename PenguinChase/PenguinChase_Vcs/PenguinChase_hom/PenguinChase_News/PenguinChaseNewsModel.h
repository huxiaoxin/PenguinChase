//
//  PenguinChaseNewsModel.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/8.
//

#import "PenguinChaseBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseNewsModel : PenguinChaseBaseModel
@property(nonatomic,copy) NSString * imgUrl;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * content;
@property(nonatomic,assign) NSInteger viewsNum;
@property(nonatomic,assign) NSInteger news_ID;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,assign) CGFloat      height;
@property(nonatomic,assign) CGFloat    width;
@property(nonatomic,copy) NSString *src;
@end

NS_ASSUME_NONNULL_END
