//
//  PhotoRequest.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "PhotoRequest.h"
#import "Photo.h"

@implementation PhotoRequest


+ (void)getImageFromBaiduWithDict:(NSDictionary *)dict
                             tag1:(NSString *)tag1
                             tag2:(NSString *)tag2
                          succeed:(void (^)(NSArray *dataArray))succeed
                           failed:(FailedCallback)failed
{
    NSString *urlstr = [NSString stringWithFormat:@"http://image.baidu.com/wisebrowse/data?tag1=%@&tag2=%@",tag1,tag2];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[BBJHttpTool sharedNetWorkManager] getObject:urlstr parameter:dict succeeded:^(NSDictionary *resultOject) {
       // NSLog(@"%@",resultOject[@"imgs"]);
        NSArray *dataArray = [HVEntity parseToEntityArray:resultOject[@"imgs"] withType:[Photo class]];
        if (dataArray.count > 0) {
            succeed(dataArray);
        }
    } failed:^(NSError *error) {
        failed(error);
    }];
}
@end
