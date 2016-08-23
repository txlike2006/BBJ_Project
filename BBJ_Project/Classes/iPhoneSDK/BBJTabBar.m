//
//  BBJTabBar.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJTabBar.h"

@interface BBJTabBar()

@property(nonatomic,retain) NSMutableArray *items;
@property(nonatomic,assign) NSUInteger selectedIndex;
@property(nonatomic,retain) UIView *barPanel;

@end

@implementation BBJTabBar

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<BBJTabBarDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.items = [items copy];
        [self shareInit];
    }
    return self;
}

- (void)shareInit
{
    /// bar panel
    
    //    if (SYSTEM_VERSION >= 8.0) {
    //        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    //        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //        effectView.frame = self.bounds;
    //        effectView.tintColor = [UIColor whiteColor];
    //        [self addSubview:effectView];
    //        self.barPanel = effectView.contentView;
    //    }
    //    else
    //    {
    self.barPanel = [[UIView alloc]initWithFrame:self.bounds];
    self.barPanel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.barPanel];
    //    }
    
    
    //描边
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 1 / [UIScreen mainScreen].scale)];
    topLine.backgroundColor = RGB(197,197,197);
    [self addSubview:topLine];
    [self bringSubviewToFront:topLine];
    
    
    
    self.selectedIndex = 0;
    
    [self addItems];
//    self.ptpModuleName = @"_tabfoot";
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.barPanel.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}


- (void)selectItemAtIndex:(NSInteger)index
{
    if (index < self.items.count) {
        [self tabBarItemdidSelected:self.items[index]];
    }
    
}

- (void)setBadge:(NSInteger)badge atIndex:(NSInteger)index
{
    BBJTabBarItem *item = self.items[index];
    [item.badgeView setBadgeNum:badge];
}

#pragma -mark
#pragma -mark reload data

- (void)addItems
{
    NSUInteger barNum = self.items.count;
    
    CGFloat width = (self.width) / barNum;
    CGFloat xOffset = 0.0f;
    
    for (int i = 0; i < barNum; i++) {
        BBJTabBarItem *item = self.items[i];
        item.width = width;
        item.height = self.height;
        item.left = xOffset;
        item.delegate = self;
        if (i == self.selectedIndex) {
            item.selected = YES;
        }
        item.tag = -i;
        xOffset += width;
        
        [self.barPanel addSubview:item];
    }
}

#pragma -mark
#pragma -mark tabbar item delegate
- (void)tabBarItemdidSelected:(BBJTabBarItem *)item{
    
    NSUInteger index = -item.tag;
    
    if (index >= [self.items count]) {
        return;
    }
    
    if (self.selectedIndex != index) {
        
        BOOL shouldSelect = YES;
        if ([self.delegate respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)]) {
            shouldSelect = [self.delegate tabBar:self shouldSelectItemAtIndex:index];
        }
        
        if (!shouldSelect) {
            return;
        }
        
        BBJTabBarItem* old = [self.items objectAtIndex:self.selectedIndex];
        if (old) {
            old.selected = NO;
        }
    }
    
    self.selectedIndex = index;
    item.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        [self.delegate tabBar:self didSelectItemAtIndex:index];
    }
}


@end
