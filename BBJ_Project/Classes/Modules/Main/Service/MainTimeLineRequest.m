//
//  MainTimeLineRequest.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/23.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "MainTimeLineRequest.h"
#import "BBJHttpTool.h"

@implementation MainTimeLineRequest

+ (void)getMainTimeLineAtticleHeadlineWithPage:(NSInteger)page
                                      Suceeded:(void (^)(NSArray *dataModelList))succeeded
                                        failed:(FailedCallback)failed
{
    NSString *urlstr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%ld-20.html",(long)page];
   
    [[BBJHttpTool sharedNetWorkManager] getObject:urlstr succeeded:^(NSDictionary *resultOject) {
        NSArray *tempArray = [HVEntity parseToEntityArray:resultOject[@"T1348647853363"] withType:[DataModel class]];
        if (tempArray.count > 0) {
            succeeded(tempArray);
        }
        
    } failed:^(NSError *error) {
        failed(error);
    }];
    
}

+ (void)getMainTimeLineTopDataSucceeded:(void (^)(NSArray *topdata))succeeded
                                 failed:(FailedCallback)failed
{
    NSString *urlStr = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html";
    [[BBJHttpTool sharedNetWorkManager] getObject:urlStr succeeded:^(NSDictionary *resultOject) {
        NSArray *dataArray = [HVEntity parseToEntityArray:resultOject[@"T1348647853363"][0][@"ads"] withType:[TopData class]];
        succeeded(dataArray);
        NSLog(@"%@",dataArray);
    } failed:^(NSError *error) {
        failed(error);
    }];
}

@end
