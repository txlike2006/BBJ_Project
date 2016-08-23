//
//  BBJNavigationViewController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJNavigationViewController.h"

CGFloat const MGJAnimationDuration = 0.55f;
static BBJNavigationViewController *navigationController;

@interface BBJNavigationViewController (){
    BOOL    _isPopProcessing;
    BOOL    _isPushProcessing;
    BOOL    _isMoving;
}

@property(nonatomic, strong) BBJRootViewController  *popedVC;
@property(nonatomic, strong) UIView                 *maskView;

@end

@implementation BBJNavigationViewController

+ (BBJNavigationViewController *)currentNavigationController
{
    return navigationController;
}

- (id)initWithRootViewController:(BBJRootViewController *)rootViewController
{
    self = [super init];
    
    if (self) {
        self.viewControllers = [[NSMutableArray alloc] initWithObjects:rootViewController, nil];
        [self.view addSubview:rootViewController.view];
        
        self.rootViewController = rootViewController;
        self.topViewController = rootViewController;
        navigationController = self;
        return self;
    }
    
    return nil;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.viewControllers = [NSMutableArray array];
        navigationController = self;
    }
    
    return self;
}

- (void)setRootViewController:(BBJRootViewController *)rootViewController
{
    if (_rootViewController) {
        [_rootViewController removeFromParentViewController];
        [_rootViewController.view removeFromSuperview];
    }
    
    _rootViewController = rootViewController;
//    _rootViewController.mgjNavigationController = self;
    
    if (!self.viewControllers) {
        self.viewControllers = [[NSMutableArray alloc] initWithObjects:self.rootViewController, nil];
    } else {
        for (BBJRootViewController *vc in self.viewControllers) {
            [vc removeFromParentViewController];
        }
        [self.viewControllers removeAllObjects];
        [self.viewControllers addObject:self.rootViewController];
        
    }
    
    self.rootViewController.view.frame = self.view.bounds;
    [self addChildViewController:self.rootViewController];
    [self.view addSubview:self.rootViewController.view];
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
    }
    
    return _maskView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - push view controller

- (void)pushViewController:(BBJRootViewController *)viewController
{
    [self pushViewController:viewController withAnimation:viewController.animation];
}

- (void)pushViewController:(BBJRootViewController *)viewController completed:(void (^)(void))completed
{
    [self pushViewController:viewController withAnimation:viewController.animation completed:completed];
}

- (void)pushViewController:(BBJRootViewController *)viewController withAnimation:(PageTransitionAnimation)animation
{
    [self pushViewController:viewController withAnimation:animation completed:nil];
}

- (void)pushViewController:(BBJRootViewController *)viewController withAnimation:(PageTransitionAnimation)animation completed:(void (^)(void))completed
{
    if (_isPushProcessing) {
//        MGJLog(@"NavigationController is pushing VC, so %@ can't be pushed now", viewController);
        return;
    }
    
    _isPushProcessing = YES;
    
    viewController.defaultFrame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    BBJRootViewController *oldViewController = [self.viewControllers lastObject];
    [self.viewControllers addObject:viewController];
    [self addChildViewController:viewController];
//    viewController.mgjNavigationController = self;
    viewController.animation = animation;
    
    if ((AnimationSlideHorizontal == animation) || (AnimationSlideVertical == animation)) {
        if (None != animation) {
            if (!self.maskView.superview) {
                [self.view addSubview:self.maskView];
            } else {
                [self.view bringSubviewToFront:self.maskView];
            }
            switch (animation) {
                case AnimationSlideHorizontal:
                {
                    [self pushViewController:viewController oldViewController:oldViewController withSlideDirection:@"horizontal" completed:completed];
                    if (!viewController.disablePanGesture) {
                        [self addPanRecognizerToViewController:viewController];
                    }
                }
                    break;
                    
                case AnimationSlideVertical:
                {
                    [self pushViewController:viewController oldViewController:oldViewController withSlideDirection:@"vertical" completed:completed];
                }
                    break;
                    
                default:
                    break;
            }
        }
    } else if (AnimationFade == animation) {
        CGRect originalRect = CGRectMake(0, 0, viewController.view.width, viewController.view.height);
        viewController.view.frame = originalRect;
        [self.view addSubview:viewController.view];
        viewController.view.alpha = 0;
        
//        @weakify(self);
        [oldViewController viewWillDisappear:YES];
        [UIView animateWithDuration:MGJAnimationDuration
                         animations:^{
                             viewController.view.alpha = 1;
                         } completion:^(BOOL finished) {
//                             @strongify(self);
                             _isPushProcessing = NO;
                             
                             [oldViewController viewDidDisappear:YES];
                             [viewController didMoveToParentViewController:self];
                             if ([self.delegate respondsToSelector:@selector(navigationController:didPushFromViewController:toViewController:)]) {
                                 [self.delegate navigationController:self didPushFromViewController:oldViewController toViewController:viewController];
                             }
                             
                             if (completed) {
                                 completed();
                             }
                             
                         }];
    } else {
        CGRect originalRect = CGRectMake(0, 0, viewController.view.width, viewController.view.height);
        viewController.view.frame = originalRect;
        [self.view addSubview:viewController.view];
        _isPushProcessing = NO;
        
        [oldViewController viewWillDisappear:YES];
        [oldViewController viewDidDisappear:YES];
        [viewController didMoveToParentViewController:self];
        
        if ([self.delegate respondsToSelector:@selector(navigationController:didPushFromViewController:toViewController:)]) {
            [self.delegate navigationController:self didPushFromViewController:oldViewController toViewController:viewController];
        }
        if (completed) {
            completed();
        }
        
        
    }
    
    self.topViewController = viewController;
}

- (void)pushViewController:(BBJRootViewController *)viewController oldViewController:(BBJRootViewController *)oldViewController withSlideDirection:(NSString *)direction completed:(void (^)(void))completed
{
    CGRect  originalRect = CGRectMake(0, 0, viewController.view.width, viewController.view.height);
    CGRect  tempRect = CGRectZero;
    
    if ([@"horizontal" isEqualToString : direction]) {
        tempRect = CGRectMake(originalRect.origin.x + originalRect.size.width, originalRect.origin.y, originalRect.size.width, originalRect.size.height);
    } else if ([@"vertical" isEqualToString : direction]) {
        tempRect = CGRectMake(originalRect.origin.x, originalRect.origin.y + originalRect.size.height, originalRect.size.width, originalRect.size.height);
    }
    
    viewController.view.frame = tempRect;
    [self.view addSubview:viewController.view];
    oldViewController.view.clipsToBounds = YES;
    self.maskView.alpha = 0;
    
    [oldViewController viewWillDisappear:YES];
    
//    @weakify(self);
    
    void (^animation)() = ^(){
//        @strongify(self);
        if ([direction isEqualToString:@"horizontal"]) {
            oldViewController.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -CGRectGetWidth(oldViewController.view.bounds) / 3.0, 0);
        }
        
        viewController.view.frame = originalRect;
        self.maskView.alpha = 0.5;
    };
    
    void (^completion)() = ^() {
//        @strongify(self);
        _isPushProcessing = NO;
        
        [self.maskView removeFromSuperview];
        
        [oldViewController viewDidDisappear:YES];
        oldViewController.view.transform = CGAffineTransformIdentity;
        [viewController didMoveToParentViewController:self];
        
        if ([self.delegate respondsToSelector:@selector(navigationController:didPushFromViewController:toViewController:)]) {
            [self.delegate navigationController:self didPushFromViewController:oldViewController toViewController:viewController];
        }
        
        if (completed) {
            completed();
        }
    };
    
    [UIView animateWithDuration:MGJAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        animation();
    } completion:^(BOOL finished) {
        completion();
    }];
}

#pragma mark - pop view controller

- (BBJRootViewController *)popViewController
{
    return [self popViewControllerWithAnimation:None];
}

- (BBJRootViewController *)popViewControllerWithAnimation:(PageTransitionAnimation)animation
{
    return [self popViewControllerWithAnimation:animation completed:nil];
}

- (BBJRootViewController *)popViewControllerWithAnimation:(PageTransitionAnimation)animation completed:(void (^)(void))completed
{
    if (_isPopProcessing) {
        return nil;
    }
    
    _isPopProcessing = YES;
    
    NSInteger               viewControllerCount = [self.viewControllers count];
    BBJRootViewController   *popedViewController = [self.viewControllers lastObject];
    
    if (viewControllerCount > 1) {
        if ((AnimationSlideHorizontal == animation) || (AnimationSlideVertical == animation)) {
            if (None != animation) {
                [self.viewControllers removeObject:popedViewController];
                self.topViewController = [self.viewControllers lastObject];
                if (!self.topViewController.view.superview) {
                    [self.view insertSubview:self.topViewController.view belowSubview:popedViewController.view];
                }
                [self addChildViewController:self.topViewController];
                
                // 这块不需要再生成一个，在某些情况下，比如大图浏览时，会导致背景是黑色的
                // 而且这个 maskView 在 pop 时会动态生成，所以这一步不需要
                // @limboy
                //                if (!self.maskView.superview) {
                //                    [self.view insertSubview:self.maskView belowSubview:popedViewController.view];
                //                }
                
                switch (animation) {
                    case AnimationSlideHorizontal:
                    {
//                        [self slidePopViewController:popedViewController withDirection:@"horizontal" completed:completed];
                    }
                        break;
                        
                    case AnimationSlideVertical:
                    {
//                        [self slidePopViewController:popedViewController withDirection:@"vertical" completed:completed];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        } else if (AnimationFade == animation) {
            [self.viewControllers removeObject:popedViewController];
            [popedViewController removeFromParentViewController];
            self.topViewController = [self.viewControllers lastObject];
            [self.view insertSubview:self.topViewController.view belowSubview:popedViewController.view];
            [self addChildViewController:self.topViewController];
            [self.topViewController viewWillAppear:YES];
//            @weakify(self);
            [UIView animateWithDuration:MGJAnimationDuration
                             animations:^{
                                 popedViewController.view.alpha = 0;
                             } completion:^(BOOL finished) {
//                                 @strongify(self);
                                 _isPopProcessing = NO;
                                 
                                 [popedViewController willMoveToParentViewController:nil];
                                 [popedViewController.view removeFromSuperview];
                                 [popedViewController removeFromParentViewController];
                                 [popedViewController didMoveToParentViewController:nil];
                                 
                                 [self.topViewController viewDidAppear:YES];
                                 
                                 if ([self.delegate respondsToSelector:@selector(navigationController:didPopFromViewController:toViewController:)]) {
                                     [self.delegate navigationController:self didPopFromViewController:popedViewController toViewController:self.topViewController];
                                 }
                                 
                                 if (completed) {
                                     completed();
                                 }
                                 
                             }];
        } else {
            popedViewController = [self.viewControllers lastObject];
            [self removeViewController:popedViewController];
            self.topViewController = [self.viewControllers lastObject];
            [self.view addSubview:self.topViewController.view];
            [self addChildViewController:self.topViewController];
            _isPopProcessing = NO;
            
            [self.topViewController viewWillAppear:YES];
            [self.topViewController viewDidAppear:YES];
            
            if ([self.delegate respondsToSelector:@selector(navigationController:didPopFromViewController:toViewController:)]) {
                [self.delegate navigationController:self didPopFromViewController:popedViewController toViewController:self.topViewController];
            }
            
            if (completed) {
                completed();
            }
            
        }
        
        return popedViewController;
    }
    
    return nil;
}


- (void)moveViewWithX:(float)x
{
    x = x > self.view.width ? self.view.width : x;
    x = x < 0 ? 0 : x;
    
    CGRect frame = self.popedVC.view.frame;
    frame.origin.x = x;
    self.popedVC.view.frame = frame;
    
    float   alpha = 0.4 - (x / 800);
    //背景部分view滑动动画
    static NSUInteger VCCounts;
    VCCounts = self.viewControllers.count;
    if (VCCounts >= 2) {
        static UIViewController *lastBut1VC;
        lastBut1VC = [self.viewControllers objectAtIndex:(VCCounts - 2)];
        lastBut1VC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -CGRectGetWidth(lastBut1VC.view.bounds) / 3 + x / 3.0, 0);
    }
    if (!self.maskView.superview) {
        [self.view insertSubview:self.maskView belowSubview:self.popedVC.view];
    }
    self.maskView.alpha = alpha;
}

- (void)releaseViewController:(BBJRootViewController *)viewController
{
    //    NSAssert(viewController == self.topViewController, [NSString stringWithFormat:@"不能用这个方法移除 当前的 TopViewController"]);
    if (viewController == self.topViewController) {
//        DBG(@"不能用这个方法移除 当前的 TopViewController %@", viewController);
    }
    
    [viewController willMoveToParentViewController:nil];
    if (viewController.view.superview) {
        [viewController.view removeFromSuperview];
    }
    [self.viewControllers removeObject:viewController];
    [viewController removeFromParentViewController];
    [viewController didMoveToParentViewController:nil];
}

- (void)removeViewController:(BBJRootViewController *)viewController
{
    [self releaseViewController:viewController];
}

- (void)removeViewControllers:(NSArray *)viewcontrollers
{
    for (BBJRootViewController *vc in viewcontrollers) {
        [self releaseViewController:vc];
    }
}

- (void)popToViewController:(BBJRootViewController *)viewController animated:(BOOL)animated
{
    [self popToViewController:viewController animated:animated completed:nil];
}

- (void)popToViewController:(BBJRootViewController *)viewController animated:(BOOL)animated completed:(void (^)(void))completed
{
    if ([self.viewControllers containsObject:viewController]) {
        BBJRootViewController *presentViewController = [self.viewControllers objectAtIndex:[self.viewControllers count] - 2];
        
        while (![presentViewController isEqual:viewController]) {
            NSInteger viewControllerCount = [self.viewControllers count];
            [self removeViewController:[self.viewControllers objectAtIndex:viewControllerCount - 2]];
            presentViewController = [self.viewControllers objectAtIndex:[self.viewControllers count] - 2];
        }
    }
    
    if (animated) {
        [self popViewControllerWithAnimation:self.topViewController.animation completed:completed];
    } else {
        [self popViewControllerWithAnimation:None completed:completed];
    }
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [self popToRootViewControllerAnimated:animated completed:nil];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated completed:(void (^)(void))completed
{
    if (self.viewControllers.count >= 2) {
        BBJRootViewController *presentViewController = [self.viewControllers objectAtIndex:[self.viewControllers count] - 2];
        
        while (![presentViewController isEqual:[self.viewControllers objectAtIndex:0]]) {
            NSInteger viewControllerCount = [self.viewControllers count];
            [self removeViewController:[self.viewControllers objectAtIndex:viewControllerCount - 2]];
            presentViewController = [self.viewControllers objectAtIndex:[self.viewControllers count] - 2];
        }
        
        if (animated) {
            [self popViewControllerWithAnimation:self.topViewController.animation completed:completed];
        } else {
            [self popViewController];
        }
    }
}

#pragma mark - Gestures
- (void)addPanRecognizerToViewController:(BBJRootViewController *)viewController
{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGestureRecognizer.delegate = viewController;
    [viewController.view addGestureRecognizer:panGestureRecognizer];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
    if([self.viewControllers.lastObject respondsToSelector:@selector(disablePanGesture)] && [self.viewControllers.lastObject disablePanGesture]){
        return;
    }
    
    static CGPoint startLocation;
    
    CGPoint translation = [recognizer translationInView:[UIApplication sharedApplication].keyWindow];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startLocation = translation;
        _isMoving = YES;
        self.popedVC = [self.viewControllers lastObject];
        if (self.popedVC) {
            [self.popedVC viewWillDisappear:YES];
        }
        // 手动设置下面那个VC的 viewWillAppear
        if (self.viewControllers.count > 1) {
            BBJRootViewController *presentingViewController = [self.viewControllers objectAtIndex:[self.viewControllers count] - 2];
            [presentingViewController viewWillAppear:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (0 > translation.x) {
            recognizer.view.left = self.view.left;
//            [self slidePopViewControllerWithGesture:NO];
        } else if (translation.x - startLocation.x > 50) {
            
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            CGFloat velocityStart = velocity.x / (self.view.width - recognizer.view.left);
            
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:velocityStart options:0 animations:^{
//                [self slidePopViewControllerAnimationWithX:self.view.width];
            } completion:^(BOOL finished) {
                _isMoving = NO;
//                [self slidePopViewControllerWithGesture:YES];
            }];
        } else {
            [self cancelSlide];
        }
        
        return;
    } else if (recognizer.state == UIGestureRecognizerStateCancelled) {
        [self cancelSlide];
        
        return;
    }
    
    if (_isMoving) {
//        float x = translation.x - startLocation.x;
//        [self slidePopViewControllerAnimationWithX:x];
    }
}

- (void)cancelSlide
{
    if (self.viewControllers.count >= 2) {
        UIViewController *lastBut1VC = [self.viewControllers objectAtIndex:(self.viewControllers.count - 2)];
        [lastBut1VC viewWillDisappear:YES];
    }
    [self.topViewController viewWillAppear:YES];
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
//        [self slidePopViewControllerAnimationWithX:0.f];
    } completion:^(BOOL finished) {
        _isMoving = NO;
//        [self slidePopViewControllerWithGesture:NO];
    }];
}



@end
