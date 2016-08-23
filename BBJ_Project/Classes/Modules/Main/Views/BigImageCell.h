//
//  BigImageCell.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJTableViewCell.h"

@class DataModel;
@interface BigImageCell : BBJTableViewCell
@property (nonatomic , strong) DataModel *dataModel;
/**
 *  标题
 */
@property (nonatomic , weak) UILabel *titleL;
/**
 *  描述
 */
@property (nonatomic , weak) UILabel *lblSubtitle;
/**
 *  跟帖
 */
@property (nonatomic , weak) UILabel *lblReply;
/**
 *  大图
 */
@property (nonatomic , weak) UIImageView *image1;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
