//
//  PenguinChaseVideoModel.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseVideoModel : NSObject
@property(nonatomic,copy) NSString * penguinChase_MoviewName;
@property(nonatomic,copy) NSString * penguinChase_EngilshMoviewName;
@property(nonatomic,copy) NSString * penguinChase_MoviewIocnurl;
@property(nonatomic,copy) NSArray  * penguinChase_MoviewImgArr;
@property(nonatomic,copy) NSString * penguinChase_MoviewTitle;
@property(nonatomic,copy) NSString * penguinChase_MoviewDesc;
@property(nonatomic,copy) NSArray  * penguinChase_MoviewArtistArr;
@property(nonatomic,copy) NSString  * penguinChase_MoviewTime;
@property(nonatomic,copy) NSString  * penguinChase_MoviewType;
@property(nonatomic,assign) BOOL     penguinChase_isColltecd;
@property(nonatomic,assign) NSInteger  penguinChase_DBSourecd;
@property(nonatomic,assign) NSInteger  penguinChase_RateSourecd;
@property(nonatomic,assign) NSInteger  penguinChase_MoviewID;
@property(nonatomic,copy)   NSString *    TopType;
@property(nonatomic,assign) NSInteger  WantNums;
@property(nonatomic,assign) NSInteger   PenguinChase_starNum;
@property(nonatomic,assign) BOOL  isViews;
@end

NS_ASSUME_NONNULL_END
