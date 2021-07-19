//
//  ORColorAppearanceHeader.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/11/1.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#ifndef ORColorAppearanceHeader_h
#define ORColorAppearanceHeader_h

/*******颜色规范*******/
#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGBA_HexCOLOR(rgbValue, A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]
#define RandomColor RGBA_COLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256),1)

// 主题色
#define gnh_color_theme RGBA_HexCOLOR(0x17CC90, 1)

// 通用背景色
#define gnh_color_com RGBA_HexCOLOR(0xF8F8F8, 1)

// 自定义颜色
#define gnh_color_a RGBA_HexCOLOR(0x333333, 1)
#define gnh_color_b RGBA_HexCOLOR(0xFFFFFF, 1)
#define gnh_color_c RGBA_HexCOLOR(0xF6F6FA, 1)
#define gnh_color_d RGBA_HexCOLOR(0xF2F1F6, 1)
#define gnh_color_e RGBA_HexCOLOR(0x999999, 1)
#define gnh_color_f RGBA_HexCOLOR(0x666666, 1)
#define gnh_color_g RGBA_HexCOLOR(0xFE4A25, 1)
#define gnh_color_h RGBA_HexCOLOR(0xF1F1F1, 1)
#define gnh_color_i RGBA_HexCOLOR(0x41444D, 1)
#define gnh_color_j RGBA_HexCOLOR(0x8A8C99, 1)
#define gnh_color_k RGBA_HexCOLOR(0x1F2025, 1)
#define gnh_color_m RGBA_HexCOLOR(0x3B3D41, 1)
#define gnh_color_n RGBA_HexCOLOR(0xECEFF2, 1)
#define gnh_color_o RGBA_HexCOLOR(0x676A73, 1)
#define gnh_color_p RGBA_HexCOLOR(0x31333A, 1)
#define gnh_color_q RGBA_HexCOLOR(0xE0F4ED, 1)
#define gnh_color_r RGBA_HexCOLOR(0x323C45, 1)
#define gnh_color_s RGBA_HexCOLOR(0x808183, 1)
#define gnh_color_t RGBA_HexCOLOR(0xD2D2D2, 1)
#define gnh_color_u RGBA_HexCOLOR(0x6A6A6E, 1)
#define gnh_color_v RGBA_HexCOLOR(0x2C62BC, 1)

#define gnh_color_w RGBA_HexCOLOR(0x94DCF6, 1)

#define gnh_color_line RGBA_HexCOLOR(0xE7E7E7, 1)

#define gnh_color_bb RGBA_HexCOLOR(0x949494, 1)
#define gnh_color_dd RGBA_HexCOLOR(0xD8D8D8, 1)
#define gnh_color_ee RGBA_HexCOLOR(0xD7D7D7, 1)
#define gnh_color_ff RGBA_HexCOLOR(0x007AFF, 1)
#define gnh_color_gg RGBA_HexCOLOR(0x1677FF, 1)
#define gnh_color_hh RGBA_HexCOLOR(0xF7F7F7, 1)
#define gnh_color_ss RGBA_HexCOLOR(0xF2F2F2, 1)




#endif /* ORColorAppearanceHeader_h */
