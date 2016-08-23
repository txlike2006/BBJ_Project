//
//  WaterflowLayout.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterflowLayout;
@protocol WaterFlowLayoutDelegate <NSObject>

- (CGFloat)warterFlowLayout:(WaterflowLayout *)warterFlowLayout heightFowWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@end

@interface WaterflowLayout : UICollectionViewLayout

@property (nonatomic ,assign) UIEdgeInsets sectionInset;
@property (nonatomic ,assign) CGFloat columMargin;
@property (nonatomic ,assign) CGFloat rowMargin;
@property (nonatomic ,assign) int columnsCount;

@property (nonatomic ,weak) id <WaterFlowLayoutDelegate>delegate;

@end
