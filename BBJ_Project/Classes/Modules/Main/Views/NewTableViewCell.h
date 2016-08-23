//
//  NewTableViewCell.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/24.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJTableViewCell.h"

@class NewDataFrame;
@interface NewTableViewCell : BBJTableViewCell

@property (nonatomic , strong) NewDataFrame *dataFrame;


@property (nonatomic , weak) UIImageView *imageV;
@property (nonatomic , weak) UILabel *titleLabel;
@property (nonatomic , weak) UILabel *timeLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
