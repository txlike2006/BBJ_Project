//
//  BBJTabBarController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/3.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJTabBarController.h"

CGFloat const BBJTabbarHeight = 49.f;

@interface BBJTabBarController ()
@property(nonatomic, strong) BBJTabBar *bbjTabBar;
@property(nonatomic, strong) NSArray *viewControllers;
@property(nonatomic, strong) BBJRootViewController *selectedViewController;
@property(nonatomic, assign) NSInteger selectIndex;
@property(nonatomic, assign) BOOL didAppear;
@end

@implementation BBJTabBarController

- (id)initWithViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self) {
        self.viewControllers = viewControllers;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.didAppear) {
//        self.selectedViewController.enableTrackPageAnalyticsAfterViewWillDisappear = NO;
        [self.selectedViewController viewWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.didAppear) {
        [self.selectedViewController viewDidAppear:animated];
//        self.selectedViewController.enableTrackPageAnalyticsAfterViewWillDisappear = YES;
    }
    self.didAppear = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.selectedViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.selectedViewController viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (BBJRootViewController *viewController in self.viewControllers)
    {
        viewController.defaultFrame = CGRectMake(0, 0, self.view.width, self.view.height - BBJTabbarHeight);
        
        BBJTabBarItem *tabBarItem = viewController.bbjTabBarItem;
        if (!tabBarItem)
        {
            tabBarItem = [[BBJTabBarItem alloc] initWithTitle:viewController.title titleColor:RGB(51, 51, 51) selectedTitleColor:RGB(51, 51, 51) icon:nil selectedIcon:nil];
            viewController.bbjTabBarItem = tabBarItem;
        }
        [itemsArray addObject:tabBarItem];
        [self addChildViewController:viewController];
        viewController.bbjTabBarController = self;
    }
    
    self.selectIndex = 0;
    self.selectedViewController = self.viewControllers[0];
    [self.view addSubview:[self.viewControllers[self.selectIndex] view]];
    
    self.bbjTabBar = [[BBJTabBar alloc] initWithFrame:CGRectMake(0, self.view.height - BBJTabbarHeight, self.view.width, BBJTabbarHeight) items:itemsArray delegate:self];
    
    [self.view addSubview:self.bbjTabBar];
}

- (void)selectAtIndex:(NSInteger)index {
    if (index > self.viewControllers.count - 1) {
        return;
    }
    [self.bbjTabBar selectItemAtIndex:index];
}

- (void)setMgjNavigationController:(BBJNavigationViewController *)bbjNavigationController
{
    [super setBbjNavigationController:bbjNavigationController];
    for (BBJRootViewController *vc in self.viewControllers) {
        vc.bbjNavigationController = bbjNavigationController;
    }
}
#pragma mark - MGJTabBarDelegate

- (BOOL)tabBar:(BBJTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index
{
    BOOL shouldSelect = YES;
    if ([self.bbjTabBarControllerDelegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:atIndex:)]) {
        shouldSelect = [self.bbjTabBarControllerDelegate tabBarController:self shouldSelectViewController:self.viewControllers[index] atIndex:index];
    }
    
    return shouldSelect;
}

- (void)tabBar:(BBJTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index
{
    if (self.selectIndex == index) {
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarControllerWhenAppeared)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarControllerWhenAppeared) withObject:nil];
        }
    }
    else
    {
        [self.selectedViewController.view removeFromSuperview];
        
        self.selectIndex = index;
        self.selectedViewController = self.viewControllers[self.selectIndex];
        
        [self.view insertSubview:self.selectedViewController.view belowSubview:self.bbjTabBar];
        
        if ([self.bbjTabBarControllerDelegate respondsToSelector:@selector(tabBarController:didSelectViewController:atIndex:)]) {
            [self.bbjTabBarControllerDelegate tabBarController:self didSelectViewController:self.selectedViewController atIndex:self.selectIndex];
        }
        
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarController)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarController) withObject:nil];
        }
    }
    
}


- (void)statusBarFrameDidChanged
{
    [super statusBarFrameDidChanged];
    self.bbjTabBar.bottom = self.view.height - ([self.view convertPoint:CGPointMake(0, self.view.height) toView:nil].y - [UIApplication sharedApplication].keyWindow.size.height);
}
@end
