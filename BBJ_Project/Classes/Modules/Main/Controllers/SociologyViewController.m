//
//  SociologyViewController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/20.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "SociologyViewController.h"
#import "SDCycleScrollView.h"
#import "MainTimeLineRequest.h"

#import "NewData.h"
#import "TopData.h"
#import "NewDataFrame.h"

#import "DataModel.h"
#import "NewsCell.h"
#import "ImagesCell.h"
#import "BigImageCell.h"
#import "TopCell.h"

#import "NewsDetailViewController.h"


@interface SociologyViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic , strong) NSMutableArray *imagesArray;
@property (nonatomic , strong) NSMutableArray *titleArray;
@property (nonatomic , strong) NSMutableArray *topArray;
@property (nonatomic , strong) NSMutableArray *totalArray;


@property (nonatomic , assign) int page;
@end

@implementation SociologyViewController

-(NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

-(NSMutableArray *)topArray
{
    if (!_topArray) {
        _topArray = [NSMutableArray array];
    }
    return _topArray;
}

-(NSMutableArray *)totalArray
{
    if (!_totalArray) {
        _totalArray = [NSMutableArray array];
    }
    return _totalArray;
}


- (void)viewDidLoad {
    self.hideNavigationBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    [self initTopNet];
    [self setupRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTableView
{
    [super addTableView];
}

-(void)initTopNet
{
    [MainTimeLineRequest getMainTimeLineTopDataSucceeded:^(NSArray *topdata) {
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        NSMutableArray *titleArray = [NSMutableArray array];
        NSMutableArray *topArray = [NSMutableArray array];
        for (TopData *data in topdata) {
            [topArray addObject:data];
            [statusFrameArray addObject:data.imgsrc];
            [titleArray addObject:data.title];
        }
        [self.topArray addObjectsFromArray:topArray];
        [self.imagesArray addObjectsFromArray:statusFrameArray];
        [self.titleArray addObjectsFromArray:titleArray];
        [self initScrollView];
    } failed:^(NSError *error) {
        
    }];
}


-(void)initScrollView
{
    // 网络加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.55) imageURLStringsGroup:self.imagesArray];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.titlesGroup = self.titleArray;
    cycleScrollView.dotColor = [UIColor redColor];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.autoScrollTimeInterval = 3.0;
    self.tableView.tableHeaderView = cycleScrollView;
}

//集成刷新控件
-(void)setupRefreshView
{
    //1.下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    //2.上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark  下拉
-(void)loadNewData
{
    self.page = 0;
    [self requestNet:1];
     [self.tableView.mj_header endRefreshing];
}

#pragma mark  上拉
-(void)loadMoreData
{
    [self requestNet:2];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark 网络请求
-(void)requestNet:(int)type
{
    [MainTimeLineRequest getMainTimeLineAtticleHeadlineWithPage:self.page Suceeded:^(NSArray *dataModelList) {
        NSMutableArray *statusArray = [NSMutableArray array];
        for (DataModel *data in dataModelList) {
            [statusArray addObject:data];
        }
        
        if (type == 1) {
            self.totalArray = statusArray;
        }else{
            [self.totalArray addObjectsFromArray:statusArray];
        }
        [self.tableView reloadData];
        self.page += 20;
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataModel *newsModel = self.totalArray[indexPath.row];
    
    CGFloat rowHeight = [NewsCell heightForRow:newsModel];
    
    return rowHeight;
}



#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.totalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    DataModel *newsModel = self.totalArray[indexPath.row];
    
    NSString *ID = [NewsCell idForRow:newsModel];
    
    if ([ID isEqualToString:@"NewsCell"]) {
        
        NewsCell *cell = [NewsCell cellWithTableView:tableView];
        cell.dataModel = newsModel;
        return cell;
        
    }else if ([ID isEqualToString:@"ImagesCell"]){
        ImagesCell *cell = [ImagesCell cellWithTableView:tableView];
        cell.dataModel = newsModel;
        return cell;
    }else if ([ID isEqualToString:@"TopImageCell"]){
        
        TopCell *cell = [TopCell cellWithTableView:tableView];
        return cell;
        
    }else if([ID isEqualToString:@"TopTxtCell"]){
        
        TopCell *cell = [TopCell cellWithTableView:tableView];
        return cell;
        
    }else{
        BigImageCell *cell = [BigImageCell cellWithTableView:tableView];
        cell.dataModel = newsModel;
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DataModel *data = self.totalArray[indexPath.row];
    
    NSString *ID = [NewsCell idForRow:data];
    
    if ([ID isEqualToString:@"NewsCell"]) {
        NewsDetailViewController *detailVC = [[NewsDetailViewController alloc] init];
        detailVC.dataModel = self.totalArray[indexPath.row];
        detailVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}


@end
