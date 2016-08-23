//
//  BBJCommonMacro.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#ifndef BBJCommonMacro_h
#define BBJCommonMacro_h

// 系统版本
#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]

// 屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height

// 屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width

// 状态栏高度
#define STATUSBAR_HEIGHT      [[UIApplication sharedApplication] statusBarFrame].size.height

// 应用宽度
#define FULL_WIDTH            SCREEN_WIDTH

// 应用高度
#define FULL_HEIGHT           SCREEN_HEIGHT

// 是不是3.5寸屏（4和4s）
#define IS_IPHONE5            (SCREEN_HEIGHT >= 568)

// 导航栏高度
#define NAVBAR_HEIGHT         (44.f + STATUSBAR_HEIGHT)

// 内容高度
#define CONTENT_HEIGHT        (FULL_HEIGHT - NAVBAR_HEIGHT)

// 内容部分的 frame
#define CONTENT_VIEW_FRAME    CGRectMake(0, NAVBAR_HEIGHT, FULL_WIDTH, CONTENT_HEIGHT)

// app 的frame
#define FULL_VIEW_FRAME       CGRectMake(0, 0, FULL_WIDTH, FULL_HEIGHT)

// 图墙Cell宽度
#define WALL_CELL_WIDTH       ((FULL_WIDTH - 20.f) / 2)
// 图墙图片宽度
#define WALL_CELL_IMAGE_WIDTH WALL_CELL_WIDTH


#endif /* BBJCommonMacro_h */
