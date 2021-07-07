//
//  PenguinChaseDongtaiModel.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseDongtaiModel : NSObject
@property(nonatomic,copy) NSString * headerImgurl;
@property(nonatomic,copy) NSString * userName;
@property(nonatomic,assign) NSInteger userLevel;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,copy) NSString * content;
@property(nonatomic,copy) NSArray * imgArr;
@property(nonatomic,assign) NSInteger userID;
@property(nonatomic,assign) BOOL isLike;
@property(nonatomic,assign) CGFloat CellHeight;
@end

NS_ASSUME_NONNULL_END
