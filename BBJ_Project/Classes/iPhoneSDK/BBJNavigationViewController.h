//
//  BBJNavigationViewController.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJRootViewController.h"


@protocol BBJNavigationControllerDelegate;

@interface BBJNavigationViewController : BBJRootViewController

/**
 *  BBJNavigationControllerDelegate
 */
@property (nonatomic, weak) id<BBJNavigationControllerDelegate> delegate;

/**
 *  ViewController 数组
 */
@property(nonatomic, strong) NSMutableArray *viewControllers;

/**
 *  当前显示的 ViewController
 */
@property(nonatomic, strong) BBJRootViewController *topViewController;

/**
 *  根 ViewController
 */
@property(nonatomic, strong) BBJRootViewController *rootViewController;

/**
 *  当前使用的 navigationcontroller
 *
 *  @return
 */
+ (BBJNavigationViewController *)currentNavigationController;

/**
 *  初始化
 *
 *  @param rootViewController 根 ViewController
 *
 *  @return
 */
- (id)initWithRootViewController:(BBJRootViewController *)rootViewController;


/**
 *  push 到新的 ViewController
 *
 *  @param viewController 需要 push 的 ViewController
 */
- (void)pushViewController:(BBJRootViewController *)viewController;

/**
 *  push 到新的 ViewController
 *
 *  @param viewController 需要 push 的 ViewController
 *  @param animation      动画类型
 */
- (void)pushViewController:(BBJRootViewController *)viewController withAnimation:(PageTransitionAnimation)animation;

/**
 *  push 到新的 ViewController
 *
 *  @param viewController 需要 push 的 ViewController
 *  @param completed      动画完成后执行的 block
 */
- (void)pushViewController:(BBJRootViewController *)viewController completed:(void (^)(void))completed;


/**
 *  push 到新的 ViewController
 *
 *  @param viewController 需要 push 的 ViewController
 *  @param animation      动画类型
 *  @param completed      动画完成后执行的 block
 */
- (void)pushViewController:(BBJRootViewController *)viewController withAnimation:(PageTransitionAnimation)animation completed:(void (^)(void))completed;

/**
 *  弹出当前最上层的 viewcontroller，默认无动画
 *
 *  @return
 */
- (BBJRootViewController *)popViewController;

/**
 *  弹出当前最上层的 viewcontroller
 *
 *  @param animation 动画类型
 *
 *  @return
 */
- (BBJRootViewController *)popViewControllerWithAnimation:(PageTransitionAnimation)animation;

/**
 *  弹出当前最上层的 viewcontroller
 *
 *  @param animation 动画类型
 *  @param completed 动画完成后执行的操作
 *
 *  @return
 */
- (BBJRootViewController *)popViewControllerWithAnimation:(PageTransitionAnimation)animation completed:(void (^)(void))completed;

/**
 *  移除指定的 viewcontroller
 *
 *  @param viewController 要移除的 viewcontroller
 */
- (void)removeViewController:(BBJRootViewController *)viewController;

/**
 *  移除指定的 viewcontrollers
 *
 *  @param viewcontrollers 要移除的 viewcontroller 数组
 */
- (void)removeViewControllers:(NSArray *)viewcontrollers;

/**
 *  弹出到指定的 viewcontroller
 *
 *  @param viewController viewController
 *  @param animated       是否需要动画
 */
- (void)popToViewController:(BBJRootViewController *)viewController animated:(BOOL)animated;

/**
 *  弹出到指定的 viewcontroller
 *
 *  @param viewController viewController
 *  @param animated       是否需要动画
 *  @param completed      动画完成后执行
 */
- (void)popToViewController:(BBJRootViewController *)viewController animated:(BOOL)animated completed:(void (^)(void))completed;

/**
 *  弹出到根 viewcontroller
 *
 *  @param animated 是否需要动画
 */
- (void)popToRootViewControllerAnimated:(BOOL)animated;

/**
 *  弹出到根 viewcontroller
 *
 *  @param animated  是否需要动画
 *  @param completed 动画完成后执行
 */
- (void)popToRootViewControllerAnimated:(BOOL)animated completed:(void (^)(void))completed;

@end

/**
 *  BBJNavigationControllerDelegate
 */
@protocol BBJNavigationControllerDelegate <NSObject>

@optional
/**
 *  navigationcontroller push 完成后调用
 *
 *  @param navigationController navigationcontroller
 *  @param viewController       前一个 viewcontroller
 *  @param preViewController    要 push 的 viewcongtroller
 */
- (void)navigationController:(BBJNavigationViewController *)navigationController didPushFromViewController:(BBJRootViewController *)viewController toViewController:(BBJRootViewController *) preViewController;

/**
 *  navigationcontroller pop 完成后调用
 *
 *  @param navigationController navigationcontroller
 *  @param popedViewController       要 pop 的viewcontroller
 *  @param viewController       前一个 viewcontroller
 */
- (void)navigationController:(BBJNavigationViewController *)navigationController didPopFromViewController:(BBJRootViewController *)popedViewController toViewController:(BBJRootViewController *) viewController;

@end
