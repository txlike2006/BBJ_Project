//
//  ActivityViewController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/6.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "ActivityViewController.h"
#import "WaterflowLayout.h"
#import "PhotoCell.h"
#import "PhotoRequest.h"

#import "Photo.h"

@interface ActivityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutDelegate>

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *photoArray;
@property (nonatomic , assign) int pn;
@property (nonatomic , copy) NSString *tag1;
@property (nonatomic , copy) NSString *tag2;
@property (nonatomic , assign) NSInteger numberOfItemsInRow;
//@property (nonatomic , strong) DOPNavbarMenu *menu;
@property (nonatomic , strong) NSArray *classArray;


@end

@implementation ActivityViewController

static NSString *const ID = @"photo";

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.bbjTabBarItem = [[BBJTabBarItem alloc] initWithTitle:@"图片" titleColor:RGB(153, 153, 153) selectedTitleColor:RGB(0, 0, 0) icon:[UIImage imageNamed:@"icon_tabbar_home"] selectedIcon:[UIImage imageNamed:@"icon_tabbar_home"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBar];
    [self initCollection];
    [self setupRefreshView];
}

-(NSMutableArray *)photoArray
{
    if (!_photoArray) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}

-(void)addNavigationBar
{
    [super addNavigationBar];
    self.navigationBar.title = @"图片";
}

-(void)initCollection
{
    WaterflowLayout *layout = [[WaterflowLayout alloc]init];
    layout.columnsCount = 2;
    layout.delegate = self;
    
    // 2.创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1];
    collectionView.frame = CGRectMake(0, 64, FULL_WIDTH, FULL_HEIGHT - 64 -44);
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:ID];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

}

//集成刷新控件
-(void)setupRefreshView
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.mj_header beginRefreshing];
    
    //2.上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadNewData
{
    [self initNetWorking];
}

- (void)loadMoreData
{
    [self NetWorking];
}

-(void)initNetWorking
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"pn"] = [NSString stringWithFormat:@"%d",self.pn];
    dic[@"rn"] = @60;
    
    self.tag1 = @"美女";
    self.tag2 = @"全部";
    
    [PhotoRequest getImageFromBaiduWithDict:dic tag1:self.tag1 tag2:self.tag2 succeed:^(NSArray *dataArray) {
        
        [self.photoArray removeAllObjects];
        [self.photoArray addObjectsFromArray:dataArray];
        
        // 刷新表格
        [self.collectionView reloadData];
         [self.collectionView.mj_header endRefreshing];
        
        //[self.collectionView.footer endRefreshing];
    } failed:^(NSError *error) {
        
    }];
}

- (void)NetWorking
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"pn"] = [NSString stringWithFormat:@"%d",self.pn];
    dic[@"rn"] = @60;
    
    [PhotoRequest getImageFromBaiduWithDict:dic tag1:self.tag1 tag2:self.tag2 succeed:^(NSArray *dataArray) {
        
        [self.photoArray addObjectsFromArray:dataArray];
        
        self.pn += 60;
        
        // 刷新表格
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
        
        //[self.collectionView.footer endRefreshing];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - <HMWaterflowLayoutDelegate>

-(CGFloat)warterFlowLayout:(WaterflowLayout *)warterFlowLayout heightFowWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    Photo *photo = self.photoArray[indexPath.item];
    CGFloat height = photo.small_height / photo.small_width * width;
    return height;

}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.photo = self.photoArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
