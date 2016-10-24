//
//  ThemeManager.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/8/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

+(ThemeManager *)sharedInstance
{
    static ThemeManager *shardManager = nil;
    static dispatch_once_t predicate;
    
    _dispatch_once(&predicate, ^{
        if (shardManager == nil) {
            shardManager = [[self alloc] init];
        }
    });
    return shardManager;
}

- (void)initTheme
{
    
}

- (void)currentTheme
{
    
}

@end
