//
//  MainTitleCollectionViewCell.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/18.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "MainTitleCollectionViewCell.h"

@implementation MainTitleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor  = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 6, 70, 28)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
        UILabel *topLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        topLine.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1];
        [self.contentView addSubview:topLine];
    }
    return self;
}


@end
