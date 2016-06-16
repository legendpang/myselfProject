//
//  AboutusCell.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutusCell : UITableViewCell
- (IBAction)mobelClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *cleanLabel;
@property (strong, nonatomic) IBOutlet UILabel *trafficLabel;
@property (strong, nonatomic) IBOutlet UILabel *foodLabel;
@property (strong, nonatomic) IBOutlet UILabel *seaLabel;
@property (strong, nonatomic) IBOutlet UILabel *airLabel;

@end
