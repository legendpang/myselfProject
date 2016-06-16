//
//  PlacefViewCell.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PlacefViewCell.h"

@implementation PlacefViewCell

- (void)awakeFromNib {
    // Initialization code
    _startView = [[StarView alloc]initWithFrame:CGRectMake(100, 35, 65, 23)];
    [self.contentView addSubview:_startView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
