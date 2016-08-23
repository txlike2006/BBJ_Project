//
//  PostSelectViewController.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/6.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJRootViewController.h"

@interface PostSelectViewController : BBJRootViewController

@property(nonatomic, copy) NSString *topicTitle;
@property(nonatomic, strong) UIButton *postButton;
@property(nonatomic, assign) BOOL enableAnimation;
@property (nonatomic, readonly) BOOL isShowSelectView;

- (void)addToViewController:(BBJRootViewController *)viewController initializeFrame:(CGRect)initializeFrame hidePostButton:(BOOL)hidePostButton;

- (void)showSelectView;

@end
