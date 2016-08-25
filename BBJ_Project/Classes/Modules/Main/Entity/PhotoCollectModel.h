//
//  PhotoCollectModel.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/8/24.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "HVEntity.h"

@interface PhotoCollectModel : HVEntity

/**
 *  图片标题
 */
@property (nonatomic , copy) NSString * title;
/**
 *  图片url
 */
@property (nonatomic , copy) NSString * image_url;
/**
 *  图片宽度
 */
@property (nonatomic , assign) CGFloat  image_width;
/**
 *  图片高度
 */
@property (nonatomic , assign) CGFloat  image_height;
/**
 *  收藏时间
 */
@property (nonatomic , copy) NSString * time;

@end
