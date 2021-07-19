//
//  GNHBaseActionItemProtocol.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GNHBaseActionItemProtocol <NSObject>

@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, assign) BOOL showAccessoryView;

@property (nonatomic, copy)   NSString *didSelectSelector;

@end
