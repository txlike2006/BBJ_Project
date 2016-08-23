//
//  BBJRootViewController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJRootViewController.h"
#import "BBJNavigationViewController.h"
#import "BBJTabBarController.h"


@interface BBJRootViewController ()
@end

@implementation BBJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.top = 0;
    if (!CGRectIsEmpty(_defaultFrame)) {
        self.view.frame = _defaultFrame;
    }
    
    self.view.backgroundColor = RGB(255, 255, 255);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameDidChanged) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:[self preferredStatusBarStyle]];
//    DBG(@"viewWillAppear: %@", self);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:[self preferredStatusBarStyle]];
//    DBG(@"viewDidAppear: %@", self);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    DBG(@"viewWillDisappear: %@", self);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    DBG(@"viewDidDisappear: %@", self);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addChildViewController:(UIViewController *)childController
{
    [super addChildViewController:childController];
    if ([childController respondsToSelector:@selector(setMgjNavigationController:)] && self.bbjNavigationController) {
        [childController performSelector:@selector(setMgjNavigationController:) withObject:self.bbjNavigationController];
    }
}

- (NSMutableDictionary *)requestParams
{
    if (!_requestParams) {
        _requestParams = [NSMutableDictionary dictionary];
    }
    return _requestParams;
}

#pragma mark - UI


- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    if (_navigationBar) {
        [_navigationBar setTitle:title];
    }
}

- (void)addNavigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[BBJNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, NAVBAR_HEIGHT)];
        _navigationBar.title = self.title;
        _navigationBar.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.f];
        _navigationBar.titleLabel.textColor = RGB(51, 51, 51);
    }
    
    if (self.bbjNavigationController && self.bbjNavigationController.viewControllers.count > 1)
    {
//        UIButton *backButton = [UIButton backButtonWithTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        
//        [_navigationBar setLeftBarButton:backButton];
    }
    
    if (!_navigationBar.superview) {
        [self.view addSubview:_navigationBar];
    }
    
}

#pragma mark - data
- (void)loadData
{
    
}

- (void)loadDataSuccess:(NSDictionary *)result
{
    
}

#pragma mark - Back
- (void)back {
    [self.view endEditing:YES];
    [self.bbjNavigationController popViewControllerWithAnimation:_animation];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


- (void)statusBarFrameDidChanged
{
}

@end
