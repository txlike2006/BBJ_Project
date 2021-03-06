//
//  ImagesCell.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJTableViewCell.h"

@class DataModel;
@interface ImagesCell : BBJTableViewCell

@property (nonatomic , strong) DataModel *dataModel;

/**
 *  标题
 */
@property (nonatomic , weak) UILabel *titleL;
/**
 *  跟帖数
 */
@property (nonatomic , weak) UILabel *lblReply;

/**
 *  多图
 */
@property (nonatomic , weak) UIImageView *image1;
@property (nonatomic , weak) UIImageView *image2;
@property (nonatomic , weak) UIImageView *image3;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
