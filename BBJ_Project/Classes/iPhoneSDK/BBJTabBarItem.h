//
//  BBJTabBarItem.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBJBadgeView.h"

@protocol BBJTabBarItemDelegate;

@interface BBJTabBarItem : UIControl

@property(nonatomic, weak) id<BBJTabBarItemDelegate> delegate;
@property(nonatomic, strong) BBJBadgeView *badgeView;
@property(nonatomic, assign) UIEdgeInsets imageInset;

/**
 *  初始化 tabbaritem
 *
 *  @param title              标题
 *  @param titleColor         标题颜色
 *  @param selectedTitleColor 选中的标题颜色
 *  @param icon               icon
 *  @param selectedIcon       选中的icon
 *
 *  @return
 */
- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor icon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon;

/**
 *  设置icon
 *
 *  @param image icon 图片
 */
- (void)setIcon:(UIImage *)image;

/**
 *  设置 selectIcon
 *
 *  @param selectedIcon 选中的 icon 图片
 */
- (void)setSelectedIcon:(UIImage *)selectedIcon;
/**
 *  设置title
 *
 *  @param title 标题
 */
-(void)setTitle:(NSString*)title;
/**
 *  设置 selectedTextColor
 *
 *  @param 选中字的颜色
 */
-(void)setSelectedTextColor:(UIColor *) selectedTitleColor;

@end

/**
 *  MGJTabBarItemDelegate
 */
@protocol BBJTabBarItemDelegate <NSObject>

@optional

/**
 *  item 被选中时调用
 *
 *  @param item 当前item
 */
- (void)tabBarItemdidSelected:(BBJTabBarItem *)item;

@end
