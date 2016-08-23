//
//  PhotoCell.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;
@interface PhotoCell : UICollectionViewCell

@property (nonatomic ,strong) UIImageView *photoImage;
@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic , strong) Photo *photo;

@end
