//
//  BBJTabBar.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBJTabBarItem.h"

/**
 *  TabBar 控件
 */

@protocol BBJTabBarDelegate;

@interface BBJTabBar : UIView <BBJTabBarItemDelegate>

/**
 *  tabbardelegate
 */
@property (nonatomic, weak) id<BBJTabBarDelegate> delegate;

/**
 *  当前选中 item 的索引
 */
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;


/**
 *  创建 tabbar
 *
 *  @param frame    frame
 *  @param items    items 数组
 *  @param delegate delegate
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<BBJTabBarDelegate>)delegate;

/**
 *  设置背景
 *
 *  @param backgroundImage 背景图
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage;


/**
 *  选中某个 item
 *
 *  @param index 索引
 */
- (void)selectItemAtIndex:(NSInteger)index;

/**
 *  设置指定 item 的 badge
 *
 *  @param badge badge 数字
 *  @param index item 索引
 */
- (void)setBadge:(NSInteger)badge atIndex:(NSInteger)index;

@end


/**
 *  BBJTabBarDelegate
 */
@protocol BBJTabBarDelegate <NSObject>
@optional

/**
 *  选中了某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 */
- (void)tabBar:(BBJTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index;

/**
 *  是否能选中某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 *
 *  @return
 */
- (BOOL)tabBar:(BBJTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index;
@end
