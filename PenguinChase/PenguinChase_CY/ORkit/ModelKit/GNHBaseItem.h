//
//  GNHBaseItem.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDFBaseItem.h"
#import "GNHDataHeader.h"
#import "GNHDataModelErrorType.h"
#import "GNHBaseActionItemProtocol.h"

@interface GNHBaseItem : MDFBaseItem <GNHBaseActionItemProtocol>

@property (nonatomic, copy) NSString<MDFBaseItemUnAutoParseProperty> *didSelectSelector;
@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, assign) BOOL showAccessoryView;
@property (nonatomic, assign) CGFloat cellHeight;

@end

@interface GNHRootBaseItem : GNHBaseItem

// 状态码
@property (nonatomic, assign) NSUInteger code;
// 返回信息
@property (nonatomic, assign) NSUInteger httpStatus;
// 错误信息
@property (nonatomic, copy) NSString *msg;
// 时间戳
@property (nonatomic, assign) NSUInteger timestamp;
// 跟踪ID
@property (nonatomic, copy) NSString *trackNo;

// 标记是否已经处理过这种类型的错误，底层会统一处理部分错误码
@property (nonatomic, assign) BOOL hasHandledError;

@end
