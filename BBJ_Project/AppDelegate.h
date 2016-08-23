//
//  AppDelegate.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APPDELEGATE [AppDelegate shareDelegate]
@class BBJTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+(instancetype)shareDelegate;

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) BBJTabBarController *tabbarController;

@property (nonatomic , strong) NSMutableArray *channelList;//保存用户频道信息/全局通用

@end

