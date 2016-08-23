//
//  AppDelegate.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"
#import "BBJNavigationViewController.h"
#import "MainTimelineViewController.h"
#import "BBJTabBarController.h"
#import "ActivityViewController.h"
#import "ProfileViewController.h"
#import "CommunicationViewController.h"
#import "PostFakeViewController.h"
#import "PostSelectViewController.h"
#import "APIStoreSDK.h"

#import "BBJTabBar.h"

//APIStore ApiKey
#define APISTORE_APIKEY  @"35682eddc7e804478489eeccc09c5ad6"

#define CHANNELLIST_URL  @"http://apis.baidu.com/showapi_open_bus/channel_news/channel_news?"

@interface AppDelegate ()<BBJTabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    if (SYSTEM_VERSION >= 7) {
        if ([application respondsToSelector:@selector(setStatusBarStyle:)]) {
            [application setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }
    
    [self goMainTabbarController];
    
    return YES;
}

-(void)goMainTabbarController
{
    //tab bar controller
    self.tabbarController = [[BBJTabBarController alloc] initWithViewControllers:
                             @[[
                                [MainTimelineViewController alloc] init],
                               [[ActivityViewController alloc] init],
                               [[CommunicationViewController alloc] init],
                               [[ProfileViewController alloc] init]]];
    
    self.tabbarController.bbjTabBarControllerDelegate = self;
    
    BBJNavigationViewController *navigatioinController = [[BBJNavigationViewController alloc] initWithRootViewController:self.tabbarController];
    
//    PostSelectViewController *selectViewController = [PostSelectViewController new];
//    
//    [selectViewController addToViewController:self.tabbarController initializeFrame:CGRectMake(
//                                                                                               (self.tabbarController.view.width - BBJTabbarHeight) / 2 - 13.0f,
//                                                                                               (self.tabbarController.view.height - BBJTabbarHeight),
//                                                                                               BBJTabbarHeight + 26.0f,
//                                                                                               BBJTabbarHeight)
//                               hidePostButton:NO];
    
    
    self.window.rootViewController = navigatioinController;
    [self.window makeKeyAndVisible];
}

+(instancetype)shareDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // handle Alipay
    return YES;
}

@end
