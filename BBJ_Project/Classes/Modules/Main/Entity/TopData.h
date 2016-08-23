//
//  TopData.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/24.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "HVEntity.h"

@interface TopData : HVEntity

/**
 *  滚动条图片
 */
@property (nonatomic , copy) NSString *imgsrc;
/**
 *  滚动条标题
 */
@property (nonatomic , copy) NSString *title;
/**
 *  链接
 */
@property (nonatomic , copy) NSString *url;


/**
 *  imgurl  详细图片
 */
@property (nonatomic , copy) NSString *imgurl;
/**
 *  详细内容
 */
@property (nonatomic , copy) NSString *note;
/**
 *  标题
 */
@property (nonatomic , copy) NSString *setname;

@property (nonatomic , copy) NSString *imgtitle;


@end
