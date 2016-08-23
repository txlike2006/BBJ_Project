//
//  MainTimeLineRequest.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/23.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"
#import "TopData.h"

#define article_headline @"http://c.m.163.com/nc/article/headline/T1348647853363/%d-20.html"

@interface MainTimeLineRequest : NSObject

+ (void)getMainTimeLineAtticleHeadlineWithPage:(NSInteger)page
                                      Suceeded:(void (^)(NSArray *dataModelList))succeeded
                                        failed:(FailedCallback)failed;

+ (void)getMainTimeLineTopDataSucceeded:(void (^)(NSArray *topdata))succeeded
                                 failed:(FailedCallback)failed;

@end
