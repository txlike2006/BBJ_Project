//
//  PostSelectViewController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/6.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "PostSelectViewController.h"

@interface PostSelectViewController ()
@property(nonatomic, strong) UIControl *maskView;
@property(nonatomic, strong) UIButton *postGoodsButton;
@property(nonatomic, strong) UIButton *postPhotoButton;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic) CGRect initializeFrame;
@property(nonatomic) BOOL hidePostButton;
@property(nonatomic, strong) UIImageView *topTipImageView;
@property(nonatomic, strong) UIImageView *goodsTipImageView;
@property(nonatomic, strong) UIImageView *lifeStyleTipImageView;

@property (nonatomic, strong) UIImageView* userGuideImageView;

@end

@implementation PostSelectViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        [self addNotification];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.postButton addSubview:self.iconImageView];
    [self.view addSubview:self.postButton];
    [self enablePostButton:self.postButton animation:self.enableAnimation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self performSelector:@selector(showGuide) withObject:nil afterDelay:5.0f];
}

- (void)addToViewController:(BBJRootViewController *)viewController initializeFrame:(CGRect)initializeFrame hidePostButton:(BOOL)hidePostButton
{
    if (viewController)
    {
        self.initializeFrame = initializeFrame;
        self.hidePostButton = hidePostButton;
        self.view.frame = initializeFrame;
        [viewController addChildViewController:self];
        [viewController.view addSubview:self.view];
        
        self.postButton.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2);
        self.iconImageView.center = CGPointMake(CGRectGetWidth(self.postButton.frame) / 2, CGRectGetHeight(self.postButton.frame) / 2);
    }
}

#pragma mark Animation

- (void)enablePostButton:(UIButton *)button animation:(BOOL)animation {
    [button.layer removeAllAnimations];
    if (animation) {
        CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        pulseAnimation.duration = 1.5;
        pulseAnimation.toValue = @1.1F;
        pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pulseAnimation.autoreverses = YES;
        pulseAnimation.repeatCount = FLT_MAX;
        [button.layer addAnimation:pulseAnimation forKey:@"pulse"];
        
        CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        theAnimation.duration = 1.5;
        theAnimation.repeatCount = HUGE_VALF;
        theAnimation.autoreverses = YES;
        theAnimation.fromValue = @1.0F;
        theAnimation.toValue = @0.5F;
        [button.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    }
}

- (UIButton *)postButton
{
    if (!_postButton) {
       
        self.postButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.postButton setImage:[UIImage imageNamed:@"tabbar_icon_post"] forState:UIControlStateNormal];
        [self.postButton addTarget:self action:@selector(postButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        _postButton.frame = self.view.bounds;
    }
    return _postButton;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        self.iconImageView = [[UIImageView alloc] initWithFrame:self.postButton.bounds];
        _iconImageView.image = [UIImage imageNamed:@"icon_post_camera"];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}

- (void)postButtonTouched
{
    
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
