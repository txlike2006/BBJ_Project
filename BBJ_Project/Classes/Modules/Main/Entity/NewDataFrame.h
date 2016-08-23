//
//  NewDataFrame.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/24.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "HVEntity.h"

@class NewData;
@interface NewDataFrame : HVEntity

@property (nonatomic , strong) NewData *NewData;

@property (nonatomic , assign) CGRect descriptionF;
@property (nonatomic , assign) CGRect picUrlF;
@property (nonatomic , assign) CGRect titleF;
@property (nonatomic , assign) CGRect urlF;
@property (nonatomic , assign) CGRect ctimeF;

@property (nonatomic , assign) CGFloat cellH;

@end
