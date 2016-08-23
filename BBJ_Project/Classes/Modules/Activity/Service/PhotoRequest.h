//
//  PhotoRequest.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBJHttpTool.h"


@interface PhotoRequest : NSObject

+ (void)getImageFromBaiduWithDict:(NSDictionary *)dict
                             tag1:(NSString *)tag1
                             tag2:(NSString *)tag2
                          succeed:(void (^)(NSArray *dataArray))succeed
                           failed:(FailedCallback)failed;
@end
