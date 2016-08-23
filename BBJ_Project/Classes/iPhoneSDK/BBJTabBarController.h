//
//  BBJTabBarController.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/3.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJRootViewController.h"
#import "BBJTabBar.h"
#import "BBJNavigationViewController.h"

extern CGFloat const BBJTabbarHeight;

@protocol BBJTabBarControllerDelegate;

@interface BBJTabBarController : BBJRootViewController<BBJTabBarDelegate>

/**
 *  tabbar
 */
@property(nonatomic, strong, readonly) BBJTabBar *bbjTabBar;

/**
 *  tabbarcontroller 中的 viewcontroller
 */
@property(nonatomic, strong, readonly) NSArray *viewControllers;

/**
 *  当前选中的 viewcontroller
 */
@property(nonatomic, strong, readonly) BBJRootViewController *selectedViewController;

/**
 *  当前选中的 index
 */
@property(nonatomic, assign, readonly) NSInteger selectIndex;

/**
 *  delegate
 */
@property(nonatomic, weak) id<BBJTabBarControllerDelegate> bbjTabBarControllerDelegate;

/**
 *  初始化 tabbarcontroller
 *
 *  @param viewControllers tabbarcontroller 中的 viewcontroller
 *
 *  @return
 */
- (id)initWithViewControllers:(NSArray *)viewControllers;

/**
 *  选中某个 tab
 *
 *  @param index 索引
 */
- (void)selectAtIndex:(NSInteger)index;


@end

/**
 *  MGJTabBarControllerDelegate
 */
@protocol BBJTabBarControllerDelegate <NSObject>
@optional
/**
 *  是否能选中制定的 viewcontroller
 *
 *  @param tabBarController tabbarcontroller
 *  @param viewController   将要选中的 viewcontroller
 *  @param index            将要选中的 viewcontroller 在 tabbar 中的索引
 *
 *  @return
 */
- (BOOL)tabBarController:(BBJTabBarController *)tabBarController shouldSelectViewController:(BBJRootViewController *)viewController atIndex:(NSInteger)index;

/**
 *  选中 tabbarcontroller 中某个 viewcontroller 时调用
 *
 *  @param tabBarController tabbarcontroller
 *  @param viewController   选中的 viewcontroller
 *  @param index            选中的 viewcontroller 在 tabbar 中的索引
 */
- (void)tabBarController:(BBJTabBarController *)tabBarController didSelectViewController:(BBJRootViewController *)viewController atIndex:(NSInteger)index;

@end



/**
 *  MGJTabBarControllerProtocal 协议
 */
@protocol BBJTabBarControllerProtocal <NSObject>

@optional
/**
 *  当 viewcontroller 被选中时调用，必须是切换的情况下
 */
- (void)didSelectedInTabBarController;

/**
 *  是否能选中
 *
 *  @return
 */
- (BOOL)shoudSelectedInTabBarController;

/**
 *  点击时，当前 viewcontroller 已经是选中的情况下调用
 */
- (void)didSelectedInTabBarControllerWhenAppeared;
@end

