//
//  BBJTableViewCell.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/6.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#define MGJ_CellNormalBgColor         RGB(255, 255, 255)
#define MGJ_CellHighlightBgColor      RGB(240, 240, 240)

#import "BBJTableViewCell.h"

@implementation BBJTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.enableClickedEffect = NO;
    }
    return self;
}

- (void)reloadData{
    
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)dequeueReusableCellForTableView:(UITableView *)tableView
{
    id cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier]];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIdentifier]];
    }
    return cell;
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    if (self.enableClickedEffect) {
        if (highlighted) {
            self.contentView.backgroundColor = MGJ_CellHighlightBgColor;
            self.backgroundColor = MGJ_CellHighlightBgColor;
        }
        else{
            self.contentView.backgroundColor = MGJ_CellNormalBgColor;
            self.backgroundColor = MGJ_CellNormalBgColor;
        }
    }
}


@end
