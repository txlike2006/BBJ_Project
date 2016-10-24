//
//  UIBarButtonItem+gyh.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/8/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (gyh)

+(UIBarButtonItem *)ItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
+(UIBarButtonItem *)ItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
