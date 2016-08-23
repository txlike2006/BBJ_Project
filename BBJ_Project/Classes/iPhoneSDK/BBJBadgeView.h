//
//  BBJBadgeView.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBJBadgeView : UIView
{
    NSInteger _badgeNum;
}

/**
 *  badge 数字
 */
@property (nonatomic, assign) NSInteger badgeNum;
@end
