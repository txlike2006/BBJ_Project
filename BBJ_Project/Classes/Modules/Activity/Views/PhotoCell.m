//
//  PhotoCell.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "PhotoCell.h"
#import "Photo.h"

@implementation PhotoCell

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupViews];
        [self makeConstrain];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViews];
        [self makeConstrain];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
         [self makeConstrain];
    }
    
    return self;
}

- (void)setupViews
{
    self.photoImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.photoImage];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.alpha = 0.8;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];//FONT(11);
    
    [self.contentView addSubview:self.titleLabel];
}


- (void)makeConstrain
{
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(@(self.contentView.width));
        make.height.equalTo(@30);
        make.bottom.equalTo(@(self.photoImage.bottom));
    }];

}

-(void)setPhoto:(Photo *)photo
{
    _photo = photo;
    //图片
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo.small_url] placeholderImage:nil];
    //文字
    self.titleLabel.text = photo.title;
    
}



@end
