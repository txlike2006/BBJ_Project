//
//  VideoData.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/9/8.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "VideoData.h"

@implementation VideoData

//2015-09-29 09:56:49
-(NSString *)ptime
{
    NSString *str1 = [_ptime substringToIndex:10];
    str1 = [str1 substringFromIndex:5];
    
    return str1;
}


@end
