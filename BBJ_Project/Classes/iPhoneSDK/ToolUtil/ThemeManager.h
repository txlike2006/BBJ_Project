//
//  ThemeManager.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/8/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Bundle_Of_ThemeResouce @"ThemeResource"

#define Bundle_Path_ThemeResouce [[[NSBundle mainBundle] resourcePath] stringByAppendingString:Bundle_Of_ThemeResouce]

@interface ThemeManager : NSObject

@property (nonatomic, copy) NSString *themeName;
@property (nonatomic, copy) NSString *themePath;
@property (nonatomic, copy) NSString *themeColor;
@property (nonatomic, copy) NSString *oldColor;

+ (ThemeManager *)sharedInstance;

- (void)chageThemeWithName:(NSString *)themeName;

- (UIImage *)themedImageWithName:(NSString *)imageName;

- (NSArray *)listOfAllTheme;



@end
