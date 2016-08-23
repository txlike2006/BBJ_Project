//
//  BBJUtilMacro.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#ifndef BBJUtilMacro_h
#define BBJUtilMacro_h

//-----------------------------宏函数 start-------------------------------------
#define IsEmptyString(str) (![str isKindOfClass:[NSString class]] || (!str || [str.trim isEqualToString:@""]))

#define NSStringFromInt(intValue) [NSString stringWithFormat:@"%ld",(long)intValue]

#define DBG(format, ...) MGJLog(format, ## __VA_ARGS__)

#define HEX(hex) [UIColor colorWithHexString:(hex) alpha:1]
#define HEXA(hex,a) [UIColor colorWithHexString:(hex) alpha:a]
#define RGBA(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define RGB(r,g,b)      RGBA(r,g,b,1)
//-----------------------------宏函数 end-------------------------------------


//-----------------------------字体相关 start-------------------------------------
#define FONT(s)          [UIFont systemFontOfSize:s]
#define BOLD_FONT(s)     [UIFont boldSystemFontOfSize:s]
//-----------------------------字体相关 end-------------------------------------



#endif /* BBJUtilMacro_h */
