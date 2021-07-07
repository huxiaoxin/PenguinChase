//
//  PenguinChatMessageListModel.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChatMessageListModel : NSObject
@property(nonatomic,copy) NSString * headerimgurl;
@property(nonatomic,copy) NSString * username;
@property(nonatomic,copy) NSString * Content;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,assign) NSInteger msgNum;
@property(nonatomic,assign) NSInteger userID;
@end

NS_ASSUME_NONNULL_END
