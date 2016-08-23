//
//  NewDataFrame.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/24.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "NewDataFrame.h"
#import "NewData.h"
@implementation NewDataFrame

-(void)setNewData:(NewData *)NewData
{
    _NewData = NewData;
    
    //图片
    CGFloat picurlX = 5;
    CGFloat picurlY = 10;
    CGFloat picurlW = 100;
    CGFloat picurlH = 70;
    _picUrlF = CGRectMake(picurlX, picurlY, picurlW, picurlH);
    
    //title
    CGFloat titleX = CGRectGetMaxX(_picUrlF) + 10;
    CGFloat titleY = picurlY;
    CGFloat titleW = SCREEN_WIDTH - 5 - titleX;
    CGFloat titleH = 45;
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    _cellH = CGRectGetMaxY(_picUrlF) + 10;
    
}


@end
