//
//  BBJRootViewController.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBJNavigationBar.h"
#import "BBJTabBar.h"
//#import "BBJNavigationViewController.h"

@class BBJNavigationViewController;

@class BBJTabBarController;
@class BBJTabBarItem;
/**
 *  NavigationController 支持的动画类型
 */
typedef NS_ENUM(NSUInteger, PageTransitionAnimation) {
    /**
     *  水平动画
     */
    AnimationSlideHorizontal = 0,
    /**
     *  垂直动画
     */
    AnimationSlideVertical,
    /**
     *  淡入淡出
     */
    AnimationFade,
    /**
     *  无
     */
    None,
};


@interface BBJRootViewController : UIViewController<UIGestureRecognizerDelegate>
{
    BBJNavigationBar *_navigationBar;
}
/**
 *  禁用横滑返回功能
 */
@property (nonatomic, assign) BOOL disablePanGesture;

/**
 *  当前 viewcontroller 所在的 MGJNavigationController 的引用。如果为 nil，表示不在 MGJNavigationController 中。
 */
@property (nonatomic, weak) BBJNavigationViewController *bbjNavigationController;


/**
 *  当前 viewcontroller 所在的 MGJTabBarController 的引用。如果为 nil，表示不在 MGJTabBarController 中。
 */
@property (nonatomic, weak)  BBJTabBarController *bbjTabBarController;

/**
 *  如果在 MGJTabBarController 中使用的 TabBarItem
 */
@property (nonatomic, strong) BBJTabBarItem *bbjTabBarItem;



/**
 *  当前 ViewController 在 MGJNavigationController 中的动画。
 */
@property (nonatomic, assign) PageTransitionAnimation animation;

/**
 *  当前 ViewController 的 view 的 frame
 */
@property (nonatomic, assign) CGRect defaultFrame;

/**
 *  请求路径
 */
@property (nonatomic, strong) NSString *requestPath;

/**
 *  请求参数
 */
@property (nonatomic, strong) NSMutableDictionary *requestParams;

/**
 *  是否正在加载数据
 */
@property (nonatomic, assign) BOOL updateloading;

/**
 *  NavigationBar
 */
@property(nonatomic, strong) BBJNavigationBar *navigationBar;
/**
 *  pop 当前的 ViewController
 */
- (void)back;

/**
 *  添加 navigationbar，默认标题为 self.title, 并且会自动添加返回按钮
 */
- (void)addNavigationBar;

/**
 *  状态栏改变时调用该方法。在该方法内需要重新调整view的位置。
 */
- (void)statusBarFrameDidChanged;


/**
 *  加载数据的抽象方法
 */
- (void)loadData;

/**
 *  加载数据成功的抽象方法
 *
 *  @param result 返回数据
 */
- (void)loadDataSuccess:(NSDictionary *)result;

/**
 *  加载数据失败的抽象方法。默认会弹出错误信息。
 *
 *  @param error 错误信息
 */
//- (void)loadDataFailure:(StatusEntity *)error;

@end
