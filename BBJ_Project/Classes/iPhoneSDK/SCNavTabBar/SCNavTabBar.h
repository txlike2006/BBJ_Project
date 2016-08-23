//
//  SCNavTabBar.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/19.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCNavTabBarDelegate <NSObject>

@optional

- (void)itemDidSelectedWithIndex:(NSInteger)index;
- (void)itemDidSelectedWithIndex:(NSInteger)index withCurrentIndex:(NSInteger)currentIndex;

@end


@interface SCNavTabBar : UIView

@property (nonatomic ,weak) id<SCNavTabBarDelegate>delegate;

@property (nonatomic, strong) NSArray *topBtnNameArr;      //按钮的名称
@property (nonatomic, strong) UIColor *btnTitleSelectColor; //按钮选中的颜色
@property (nonatomic, strong) UIColor *btnTitleNormalColor; //按钮未选中的颜色
@property (nonatomic, strong) UIColor *indexLineLabelColor; //按钮下方指示线的颜色
@property (nonatomic, strong) UIFont *btnTextFont;
@property (nonatomic, assign) NSInteger currentItemIndex;//当前按钮的index

- (id)initWithFrame:(CGRect)frame;


//- (void)updateData;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;


@end
