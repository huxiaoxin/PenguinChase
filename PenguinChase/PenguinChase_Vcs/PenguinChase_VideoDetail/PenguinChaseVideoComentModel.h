//
//  PenguinChaseVideoComentModel.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseVideoComentModel : NSObject
@property(nonatomic,copy) NSString * userName;
@property(nonatomic,copy) NSString * userHeadeurl;
@property(nonatomic,assign) NSInteger starNum;
@property(nonatomic,copy) NSString * content;
@property(nonatomic,assign) NSInteger MoviewID;
@property(nonatomic,assign) NSInteger ComentID;
@property(nonatomic,assign) CGFloat CellHeight;
@end

NS_ASSUME_NONNULL_END
