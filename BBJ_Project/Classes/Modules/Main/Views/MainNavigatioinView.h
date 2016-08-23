//
//  MainNavigatioinView.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/18.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainNavigationViewDelegate <NSObject>

-(void)newsBtnDidClicked:(UIButton *)newsBtn;

-(void)serviceBtnDidClicked:(UIButton *)serviceBtn;

-(void)searchBtnDidClicked:(UIButton *)searchBtn;

@end

@interface MainNavigatioinView : UIView

@property (nonatomic ,weak) id <MainNavigationViewDelegate>delegate;

@property (nonatomic , strong) UIImageView *weatherImgView;
@property (nonatomic , strong) UILabel *loctionLabel;
@property (nonatomic , strong) UILabel *temperatureLabel;
@property (nonatomic , strong) UIButton *newsBtn;
@property (nonatomic , strong) UIButton *toolsBtn;
@property (nonatomic , strong) UIButton *searchBtn;
@property (nonatomic , strong) UILabel *bottomLine;

@end
