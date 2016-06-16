//
//  PlacefViewCell.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
@interface PlacefViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *specialLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;


@property(nonatomic,strong)StarView * startView;
@end
