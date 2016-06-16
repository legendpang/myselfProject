//
//  DetailFoodCell.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pushToFoodMap <NSObject>

-(void)pushMapPlace;

@end


@interface DetailFoodCell : UITableViewCell <UIScrollViewDelegate>
- (IBAction)mapClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;



@property (strong, nonatomic) IBOutlet UILabel *adressLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
-(void)creatImageView:(NSArray *)arr;
@property(nonatomic,assign)id<pushToFoodMap>delegate;
@end
