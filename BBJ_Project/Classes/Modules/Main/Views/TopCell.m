//
//  TopCell.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/5/25.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "TopCell.h"

@implementation TopCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Topcell";
    TopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.text = @"123";
    }
    return self;
}


@end
