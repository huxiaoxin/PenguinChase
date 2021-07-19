//
//  GNHKitNetworkAddressHeader.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#ifndef GNHKitNetworkAddressHeader_h
#define GNHKitNetworkAddressHeader_h

#pragma mark - 信息采集/上报

#pragma mark - 启动
// 上传WiFi信息
static NSString *const GNHUploadWiFiInformationAddress = @"collect/addWifi?";
//上传错误日志
static NSString *const GNHUploadErrorLogAddress = @"help/appErrorLog";
// 字段监控
static NSString *const GNHMonitorParameterAddress = @"user/authentication";
// 启动日志
static NSString *const GNHLaunchLogAddress = @"home/index/applaunchmulti";
// /*1.是否上传通讯录 2.上传通讯录地址  (上传文件)uploadContacts (上传json)uploadredis */
static NSString *const GNHUploadRedisAddress = @"order2/user/uploadredis";
static NSString *const GNHAddressBookAddress = @"tianji-contacts-ms/api/v1/upload";
// 获取用户账单
static NSString *const GNHGetUserCenterBillAddress = @"bill/getUserCenterBill";
// App 启动同步接口
static NSString *const GNHAppSyncAddress = @"appSwitch/appSyncNew";


//熊猫追剧-首页-榜单
static NSString *const pandazj_index_list = @"pandazj_index_list";
//熊猫追剧-首页-甄选好片
static NSString *const pandazj_index_hot = @"pandazj_index_hot";
//熊猫追剧-首页-影视新闻
static NSString *const pandazj_index_new = @"pandazj_index_new";
//熊猫追剧-首页-影视咨询
static NSString *const pandazj_index_consult = @"pandazj_index_consult";
//熊猫追剧-底部-动态
static NSString *const pandazj_tab_dongtai = @"pandazj_tab_dongtai";
//熊猫追剧-底部-热点
static NSString *const pandazj_tab_hotpot = @"pandazj_tab_hotpot";
//熊猫追剧-底部-发现
static NSString *const pandazj_tab_discovery = @"pandazj_tab_discovery";
//熊猫追剧-底部-我的
static NSString *const pandazj_tab_mine = @"pandazj_tab_mine";
//熊猫追剧-影视-播放
static NSString *const pandazj_video_play = @"pandazj_video_play";
//熊猫追剧-短视频-播放
static NSString *const pandazj_hotVideo_play = @"pandazj_hotVideo_play";
//熊猫追剧—我的-播放历史
static NSString *const pandazj_me_playHistory = @"pandazj_me_playHistory";
//熊猫追剧-搜索
static NSString *const pandazj_search = @"pandazj_search";



#endif /* GNHKitNetworkAddressHeader_h */
