//
//  BBJNavigationBar.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/2.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#define TAG_TITLELABEL_NAVIGATIONBAR   50000

#import "BBJNavigationBar.h"

@implementation BBJNavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame needBlurEffect:YES];
}

- (id)initWithFrame:(CGRect)frame needBlurEffect:(BOOL)needBlurEffect
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = NO;
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - STATUSBAR_HEIGHT )];
        self.containerView.bottom = self.height;
        
        self.backgroundColor = RGB(250, 250, 250);
        [self addSubview:self.containerView];
        
        //描边
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.containerView.width, 1 / [UIScreen mainScreen].scale)];
        bottomLine.bottom = self.containerView.height;
        bottomLine.backgroundColor = RGBA(4, 0, 0, 0.2);
        bottomLine.tag = 1001;
        [self.containerView addSubview:bottomLine];
        
//        self.ptpModuleName = @"_head";

    }
      
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (nil == _titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((self.containerView.width - 200)/2, 0, 200, self.containerView.height)];
    }else {
        [_titleView removeAllSubviews];
    }
    _titleView.frame = CGRectMake((self.containerView.width - 200)/2, 0, 200, self.containerView.height);
    _titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, _titleView.height - 10)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = RGB(51, 51, 51);
    titleLabel.text = _title;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumScaleFactor = 14 / 18.f;
    titleLabel.tag = TAG_TITLELABEL_NAVIGATIONBAR;
    [_titleView addSubview:titleLabel];
    
    [_titleView removeFromSuperview];
    [self.containerView addSubview:_titleView];
}

- (void)setTitleColor:(UIColor*)color
{
    UILabel *titleLabel = (UILabel*)[_titleView viewWithTag:TAG_TITLELABEL_NAVIGATIONBAR];
    titleLabel.textColor = color;
}

- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    _titleView = nil;
    if (titleView) {
        _titleView = titleView;
        _titleView.center = CGPointMake(self.containerView.width / 2, self.containerView.height / 2) ;
        [self.containerView addSubview:_titleView];
    }
}

- (UILabel *)titleLabel
{
    UILabel *titleLabel = (UILabel*)[_titleView viewWithTag:TAG_TITLELABEL_NAVIGATIONBAR];
    return titleLabel;
}

- (void)setLeftBarButton:(UIView *)leftBarButton
{
    [_leftBarButton removeFromSuperview];
    _leftBarButton = nil;
    if (leftBarButton) {
        _leftBarButton = leftBarButton;
        _leftBarButton.center = CGPointMake(_leftBarButton.width/2, self.containerView.height/2);
        
        [self.containerView addSubview:_leftBarButton];
    }
}

- (void)setRightBarButton:(UIView *)rightBarButton
{
    [_rightBarButton removeFromSuperview];
    _rightBarButton = nil;
    if (rightBarButton) {
        _rightBarButton = rightBarButton;
        _rightBarButton.center = CGPointMake(self.containerView.width - (_rightBarButton.width/2), self.containerView.height/2);
        [self.containerView addSubview:_rightBarButton];
        [self.containerView bringSubviewToFront:_rightBarButton];
    }
}


@end
