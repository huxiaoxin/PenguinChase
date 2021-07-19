//
//  ORShareChannelDataModel.h
//  AiQiu
//
//  Created by ChenYuan on 2020/5/30.
//  Copyright © 2020 lesports. All rights reserved.
//

#import "GNHBaseDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ORShareReportDataModel : GNHBaseDataModel

- (BOOL)shareReportWithType:(NSString *)videoId type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
