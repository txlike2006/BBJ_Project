//
//  TabbarButton.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/9/8.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "TabbarButton.h"

// 定义图片占据得尺寸
#define tabbarButtonRatio 0.6
//默认文字得颜色， ios6 ios7
#define tabbarButtonTitleColor [UIColor blackColor]
//按钮选中文字得颜色
#define tabbarButtonTitleSelectedColor [UIColor colorWithRed:219/255.0f green:86/255.0f blue:85/255.0f alpha:1]

@implementation TabbarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置图片，文字居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:tabbarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:tabbarButtonTitleSelectedColor forState:UIControlStateSelected];
    }
    
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imagew = contentRect.size.width;
    CGFloat imageh = contentRect.size.height * tabbarButtonRatio;
    return  CGRectMake(0, 0, imagew, imageh);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *tabbarButtonRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}


-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
}


@end









