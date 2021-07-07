//
//  PenguinChaseComentModel.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseComentModel : NSObject
@property(nonatomic,copy) NSString * headerImgurl;
@property(nonatomic,copy) NSString * userName;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,copy) NSString * content;
@property(nonatomic,assign) NSInteger zoneID;
@property(nonatomic,assign) NSInteger comentID;
@property(nonatomic,assign) CGFloat CellHeight;
@end

NS_ASSUME_NONNULL_END
