//
//  CommunicationViewController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/6.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "CommunicationViewController.h"

@interface CommunicationViewController ()

@end

@implementation CommunicationViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.bbjTabBarItem = [[BBJTabBarItem alloc] initWithTitle:@"学学学" titleColor:RGB(153, 153, 153) selectedTitleColor:RGB(0, 0, 0) icon:[UIImage imageNamed:@"icon_tabbar_home"] selectedIcon:[UIImage imageNamed:@"icon_tabbar_home"]];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBar];
}

-(void)addNavigationBar
{
    [super addNavigationBar];
    self.navigationBar.title = @"班级相册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
