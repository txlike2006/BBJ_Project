//
//  SCNavTabBar.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/19.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "SCNavTabBar.h"

#define GapOfButtons 0

@interface SCNavTabBar()
{
    NSInteger _pageIndex;
}

@property (nonatomic,assign) NSInteger indexCount;

@property (nonatomic,strong) UIScrollView *topScrollView;
@property (nonatomic,strong) UIView *topLineView; //顶部view下方的一根线
@property (nonatomic,strong) UIScrollView *bottomScrollView;
@property (nonatomic,strong) UILabel *indexLineLabel; //指示哪天的下滑线

@property (nonatomic,strong) NSMutableArray *topBtnCenterArr;           //用于记录按钮的中心
@property (nonatomic,strong) NSMutableArray *topBtnWidthArr;             //用于记录按钮的宽度
@property (nonatomic,strong) NSMutableArray *topButtonArr;       //按钮对象

@property (nonatomic,assign) BOOL isBtnClick;

@property (nonatomic ,assign) float lastBtnWidth;

@end

@implementation SCNavTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig
{
    self.topBtnCenterArr = [NSMutableArray array];
    self.topBtnWidthArr = [NSMutableArray array];
    self.topButtonArr = [NSMutableArray array];
    
    [self configureBtn];
}

-(void)configureBtn
{
    
    if(self.topLineView == nil){
        self.topLineView = [[UIView alloc] init];
        self.topLineView.frame = CGRectMake(0, 44 -0.5, FULL_WIDTH , 0.5);
        self.topLineView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.topLineView];
    }
    //放置顶部按钮的scrollview
    if (self.topScrollView == nil) {
        self.topScrollView = [[UIScrollView alloc] init];
        self.topScrollView.frame = CGRectMake(10, 0, FULL_WIDTH - 20, 44);
        self.topScrollView.showsHorizontalScrollIndicator = NO;
        self.topScrollView.backgroundColor = [UIColor clearColor];
        self.topScrollView.scrollEnabled = YES;
        [self addSubview:self.topScrollView];
        
        self.indexLineLabel = [[UILabel alloc]init];
        
    }
}


- (void)setTopBtnNameArr:(NSArray *)topBtnNameArr
{
    _topBtnNameArr = nil;
    _topBtnNameArr = topBtnNameArr;
    
    [self resetTopTabbar];
}



-(void)resetTopTabbar
{
    [self.topButtonArr removeAllObjects];
    [self.topBtnCenterArr removeAllObjects];
    [self.topBtnWidthArr removeAllObjects];
    [self.topScrollView removeAllSubviews];
    //根据传入字符串创建按钮，并计算contentSize
    //按钮的高与TopScroll一致
    float contenX = GapOfButtons;
    for (NSUInteger i = 0; i < [self.topBtnNameArr count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.topBtnNameArr[i] forState:UIControlStateNormal];
        if (self.btnTextFont == nil) {
            button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        }else{
            button.titleLabel.font = self.btnTextFont;
        }
        
        CGSize size = [button.currentTitle sizeWithFont:[UIFont systemFontOfSize:15]constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
        float btnWith = size.width + 30;
        //        btnWith = self.topBtnWidth;
        button.frame = CGRectMake(contenX, 0, btnWith, 40);
        contenX = button.frame.origin.x + btnWith + GapOfButtons;
        button.tag = 200 + i;
        [button addTarget:self action:@selector(touchTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:button];
        
        NSNumber *num = [NSNumber numberWithFloat:button.center.x];
        [self.topBtnCenterArr addObject:num];
        
        NSNumber *num1 = [NSNumber numberWithFloat:button.frame.size.width];
        [self.topBtnWidthArr addObject:num1];
        
        if (i == 0) {
            button.selected = YES;
        }
        if (i == self.topBtnNameArr.count - 1) {
            self.lastBtnWidth = button.width;
        }
        [button setTitleColor:self.btnTitleNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.btnTitleSelectColor forState:UIControlStateSelected];
        
        [self.topButtonArr addObject:button];
        NSLog(@"%@",button.titleLabel.text);
    }
    self.topScrollView.contentSize = CGSizeMake(contenX + 20, 44);
    self.topScrollView.scrollsToTop = NO;
    
    NSNumber *num = [self.topBtnCenterArr firstObject];
    NSNumber *num1 = [self.topBtnWidthArr firstObject];
    
    //self.indexLineLabel = [[UILabel alloc]init];
    self.indexLineLabel.frame = CGRectMake(num.floatValue - num1.floatValue/2, 44 - 2, num1.floatValue, 2);
    self.indexLineLabel.backgroundColor = self.indexLineLabelColor;
    [self.topScrollView addSubview:self.indexLineLabel];
}

/**
 * 点击按钮的响应方法
 *
 *  @param button 当前点击的按钮
 */
-(void)touchTopBtn:(UIButton *)button
{
    self.isBtnClick = YES;
    self.indexCount = (NSInteger)(button.tag - 200);
    
    [self btnChangeLineLabel];
    [self changeTopView];
    [self changeBtnTitleColor];
    
    self.isBtnClick = NO;
    
    [self touchTopButton:button withIndex:(NSInteger)(button.tag - 200)];
}

- (void)touchTopButton:(UIButton*)button withIndex:(NSInteger)index
{
    [self.delegate itemDidSelectedWithIndex:index withCurrentIndex:_pageIndex];
    if (_pageIndex != index) {
        _pageIndex = index;
    }   
}


#pragma -mark 改变UI, 滑动界面的时候改变UI呈现动画效果
/*改变topScrollview*/
-(void)changeTopView
{
    self.isBtnClick = NO;
    float x = [self.topBtnCenterArr[self.indexCount]floatValue];
    [UIView animateWithDuration:0.3 animations:^{
        if (x > FULL_WIDTH/2 && x < self.topScrollView.contentSize.width - FULL_WIDTH/2.0) {
            self.topScrollView.contentOffset = CGPointMake(x - FULL_WIDTH/2, 0);
        }else if(x >= self.topScrollView.contentSize.width - FULL_WIDTH/2.0){
            self.topScrollView.contentOffset = CGPointMake(self.topScrollView.contentSize.width - FULL_WIDTH,0);
        }else{
            self.topScrollView.contentOffset = CGPointMake(0, 0);
        }
    }];
}

/*改变顶层下滑线*/
-(void)btnChangeLineLabel
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.indexLineLabel.frame = CGRectMake([self.topBtnCenterArr[self.indexCount]floatValue] - [self.topBtnWidthArr[self.indexCount]floatValue]/2, 44 - 2, [self.topBtnWidthArr[self.indexCount]floatValue], 2);
    } completion:^(BOOL finished) {
        //
    }];
}
/*改变按钮颜色*/
-(void)changeBtnTitleColor
{
    for (NSUInteger i = 0; i < [self.topBtnNameArr count]; i++) {
        // UIButton *btn = (UIButton *)[self.topScrollView viewWithTag:200 + i];
        UIButton *btn = self.topButtonArr[i];
        if (i != self.indexCount) {
            btn.selected = NO;
        }else{
            btn.selected = YES;
        }
    }
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView != self.topScrollView) {
        if (!self.isBtnClick) {
            float needChange = 0;
            int titleIndex = 0;
            for (int i = 0; i < self.topBtnCenterArr.count; i++) {
                NSNumber *num = self.topBtnCenterArr[i];
                CGPoint point = self.indexLineLabel.center;
                float indexLineCenterX = self.indexLineLabel.centerX;//point.x;
                if (num.floatValue >= indexLineCenterX) {
                    if (i-1>=0) {
                        needChange = [self.topBtnCenterArr[i] floatValue] - [self.topBtnCenterArr[i - 1]floatValue];
                        titleIndex = i;
                        break;
                    }
                    
                }
            }
            float offset = 0;
            offset = needChange/FULL_WIDTH * (scrollView.contentOffset.x - (titleIndex - 1) * FULL_WIDTH);
            NSNumber *num = self.topBtnCenterArr[self.topBtnCenterArr.count - 1];
            if ((titleIndex != 0) && (titleIndex < self.topBtnCenterArr.count) && (self.indexLineLabel.centerX + offset <= num.floatValue + self.lastBtnWidth)) {
                self.indexLineLabel.center = CGPointMake([self.topBtnCenterArr[titleIndex - 1] floatValue] + offset, 44 - 2/2.0);
                self.indexLineLabel.bounds = CGRectMake(0, 0, [self.topBtnWidthArr[titleIndex - 1]floatValue] + ([self.topBtnWidthArr[titleIndex]floatValue] - [self.topBtnWidthArr[titleIndex -1]floatValue])/FULL_WIDTH *(scrollView.contentOffset.x - (titleIndex - 1) * FULL_WIDTH), 2);
            }
        }
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != self.topScrollView)
    {
        self.indexCount = (NSInteger)scrollView.contentOffset.x/FULL_WIDTH;
        [self changeTopView];
        [self changeBtnTitleColor];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ((!decelerate) && (scrollView != self.topScrollView)){
        self.indexCount = (NSInteger)scrollView.contentOffset.x/FULL_WIDTH;
        [self changeTopView];
        [self changeBtnTitleColor];
    }

}


@end
