//
//  NewsCell.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJTableViewCell.h"

@class DataModel;
@interface NewsCell : BBJTableViewCell

@property (nonatomic , strong) DataModel *dataModel;


/**
 *  图片
 */
@property (weak, nonatomic) UIImageView *imgIcon;
/**
 *  标题
 */
@property (weak, nonatomic) UILabel *lblTitle;
/**
 *  回复数
 */
@property (weak, nonatomic) UILabel *lblReply;
/**
 *  描述
 */
@property (weak, nonatomic) UILabel *lblSubtitle;
/**
 *  第二张图片（如果有的话）
 */
@property (weak, nonatomic) UIImageView *imgOther1;
/**
 *  第三张图片（如果有的话）
 */
@property (weak, nonatomic) UIImageView *imgOther2;



/**
 *  类方法返回可重用的id
 */
+ (NSString *)idForRow:(DataModel *)NewsModel;

/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(DataModel *)NewsModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
