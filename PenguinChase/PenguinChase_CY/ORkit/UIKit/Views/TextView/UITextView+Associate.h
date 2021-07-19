//
//  UITextView+Associate.h
//  AFNetworking
//
//  Created by 蔡儒楠 on 2017/10/30.
//

#import <UIKit/UIKit.h>

@interface UITextView (Associate)

@property (nonatomic, copy) NSString *textFieldName;

@property(nonatomic,assign) BOOL mdf_Pasted; //默认为NO

- (void)setUserInfo:(NSArray *)userInfo;

- (NSArray *)getUserInfo;

@end
