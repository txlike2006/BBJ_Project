//
//  NewsDetailViewController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/8/23.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "DetailImageWebModel.h"
#import "MainTimeLineRequest.h"

@interface NewsDetailViewController()<UIWebViewDelegate>

@property (nonatomic ,strong) DetailImageWebModel *detailModel;
@property (nonatomic ,weak) UIWebView *webView;
@property (nonatomic ,copy) NSString *url;

@end


@implementation NewsDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

- (void)setupUI
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 20, 54, 44);
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn setImage:[UIImage imageNamed:@"night_icon_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:btn];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.backgroundColor = [UIColor whiteColor];
    webView.top = 64;
    webView.height = SCREEN_HEIGHT - 64;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
}

-(void)addNavigationBar
{
    [super addNavigationBar];
}

- (void)setupData
{
    
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.dataModel.docid];
    
    self.url = url;
    
    [[BBJHttpTool sharedNetWorkManager] getObject:self.url succeeded:^(NSDictionary *resultOject) {
        weakSelf.detailModel = [[DetailImageWebModel alloc] initWithDictionary:resultOject];
        [weakSelf showInWebView];
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)showInWebView
{
    
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end











