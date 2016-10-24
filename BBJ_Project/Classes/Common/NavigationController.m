//
//  NavigationController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/8/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "NavigationController.h"
#import "UIBarButtonItem+gyh.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem  = [UIBarButtonItem ItemWithIcon:@"navigationbar_back_os7" highIcon:nil target:self action:@selector(back)];
    }
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

@end
