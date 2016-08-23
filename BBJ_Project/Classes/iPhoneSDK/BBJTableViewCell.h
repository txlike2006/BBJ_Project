//
//  BBJTableViewCell.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/6.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBJTableViewCell : UITableViewCell
@property(nonatomic) BOOL enableClickedEffect;

/**
 *  reloadData 方法，子类自己实现
 */
- (void)reloadData;

/**
 *  返回当前 cell 的 identifier，默认为类名
 *
 *  @return 当前 cell 的 identifier
 */
+ (NSString *)cellIdentifier;

/**
 *  返回 tableview 中可复用的cell，identifier 取当前 cell 类名
 *
 *  @param tableView tableview
 *
 *  @return
 */
+ (instancetype)dequeueReusableCellForTableView:(UITableView *)tableView;


@end
