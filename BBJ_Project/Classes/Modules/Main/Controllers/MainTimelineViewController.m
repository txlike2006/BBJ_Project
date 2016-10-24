//
//  MainTimelineViewController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/6.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "MainTimelineViewController.h"
#import "MainNavigatioinView.h"
#import "MainTitleCollectionViewCell.h"
#import "AppDelegate.h"
#import "SCNavTabBar.h"
#import "SociologyViewController.h"
#import "BBJNavigationViewController.h"

#import "STDBTool.h"


@interface MainTimelineViewController ()<SCNavTabBarDelegate,UIScrollViewDelegate>

@property (nonatomic ,strong) UIView *baseView;

@property (nonatomic ,strong) SCNavTabBar *titleCollectionView;
@property (nonatomic ,strong) UIScrollView *mainView;
@property (nonatomic ,assign)  NSInteger currentIndex;
@property (nonatomic, strong)NSMutableArray *subViewControllers;

@end

@implementation MainTimelineViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.bbjTabBarItem = [[BBJTabBarItem alloc] initWithTitle:@"发现" titleColor:RGB(153, 153, 153) selectedTitleColor:RGB(0, 0, 0) icon:[UIImage imageNamed:@"icon_tabbar_home"] selectedIcon:[UIImage imageNamed:@"icon_tabbar_home_active"]];
    }
    return self;
}

-(void)addNavigationBar
{
    [super addNavigationBar];
    self.navigationBar.title = @"新闻";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addNavigationBar];
    [self addTitleCollectionView];
    [self addBottomViewControllers];
    [self addMainView];
    
    [self testDataBase];
}

- (void)addTitleCollectionView
{
    _titleCollectionView = [[SCNavTabBar alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH , 44)];
    _titleCollectionView.delegate = self;
    _titleCollectionView.btnTitleSelectColor = [UIColor redColor];
    _titleCollectionView.btnTitleNormalColor = [UIColor blackColor];
    _titleCollectionView.indexLineLabelColor = [UIColor redColor];
    NSArray *namearray = [NSArray array];
    namearray = @[@"社会",@"国内",@"国际",@"娱乐",@"体育",@"科技",@"奇闻趣事",@"生活健康"];
    _titleCollectionView.topBtnNameArr = namearray;
    
    //titleSwipeView
    [self.view addSubview:self.titleCollectionView];
}

-(void)addMainView
{
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, 0);
    [self.view addSubview:_mainView];
    
   // 首先加载第一个视图
    UIViewController *viewController = (UIViewController *)_subViewControllers[0];
    viewController.view.frame = CGRectMake(0 , 0, SCREEN_WIDTH, _mainView.height);
    [_mainView addSubview:viewController.view];
    [self addChildViewController:viewController];
}

- (void)addBottomViewControllers
{
    NSArray *contentarray = [NSArray array];
    contentarray = @[@"shehui",@"guonei",@"world",@"huabian",@"tiyu",@"keji",@"qiwen",@"health"];
    
    _subViewControllers = [NSMutableArray array];
    
    for (int i = 1; i < contentarray.count; i++) {
        SociologyViewController *test = [[SociologyViewController alloc] init];
//        UINavigationController *testNav = [[UINavigationController alloc] initWithRootViewController:test];
        [_subViewControllers addObject:test];
    }
}


- (void)testDataBase
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [STDBTool shareInstance];
        [self insertData];
    });

}

- (void)insertData{
    NSMutableArray * sqlList = @[].mutableCopy;
    for (int i = 0 ;i < 1000000;i ++) {
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO %@ (bookId,file_version,hot_sort,pic,name,path,time) VALUES (%d,'%@','%@','%@','%@','%@',%f)",ST_TB_NAME_BOOKINFO,i,@"2",@"2.0.1",@"pic",@"网络小说",@"path",[[NSDate date]timeIntervalSince1970]];
        [sqlList addObject:sql];
    }
    NSLog(@"无事务处理开始插入数据%@",[NSDate date]);
    [[STDBTool shareInstance]executeSQLList:sqlList withBlock:^(BOOL bRet, NSString *msg) {
        NSLog(@"无事务处理插入完成数据%@",[NSDate date]);
    }];;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SCNavTabBarDelegate
-(void)itemDidSelectedWithIndex:(NSInteger)index withCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex-index>=2 || currentIndex-index<=-2) {
        [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:NO];
    }else{
        [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    }
}

#pragma mark - Scroll View Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
   
    [self.titleCollectionView scrollViewDidScroll:scrollView];
    /** 当scrollview滚动的时候加载当前视图 */
    UIViewController *viewController = (UIViewController *)_subViewControllers[_currentIndex];
    viewController.view.frame = CGRectMake(_currentIndex * SCREEN_WIDTH, 0, SCREEN_WIDTH, _mainView.frame.size.height);
    [_mainView addSubview:viewController.view];
    [self addChildViewController:viewController];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.titleCollectionView scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.titleCollectionView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

@end
