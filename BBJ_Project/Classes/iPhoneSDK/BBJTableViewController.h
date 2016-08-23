//
//  BBJTableViewController.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/6.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJRootViewController.h"

@interface BBJTableViewController : BBJRootViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/**
 *  是否不加载导航条
 */
@property(nonatomic, assign) BOOL hideNavigationBar;

/**
 *  添加 tableview，若需要修改 tableview 的大小，请重写该方法，在调用父类的 addTableView 后修改。
 */
- (void)addTableView;

@end
