//
//  Photo.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "HVEntity.h"

@interface Photo : HVEntity

@property (nonatomic, assign) CGFloat small_width;
@property (nonatomic, assign) CGFloat small_height;
@property (nonatomic, copy) NSString *small_url;
@property (nonatomic, copy) NSString *title;

@property (nonatomic , copy) NSString *image_url;
@property (nonatomic , assign) CGFloat image_width;
@property (nonatomic , assign) CGFloat image_height;


@end
