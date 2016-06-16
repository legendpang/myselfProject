//
//  AboutusCell.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AboutusCell.h"

@implementation AboutusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mobelClick:(id)sender {
  
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://12301"]];
}
@end
