//
//  DetailWebModel.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/8/23.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "HVEntity.h"

@interface DetailWebModel : HVEntity

@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *ptime;
@property (nonatomic ,copy) NSString *body;
@property (nonatomic ,strong) NSArray *img;

+(instancetype)detailWithDict:(NSDictionary *)dict;

@end
