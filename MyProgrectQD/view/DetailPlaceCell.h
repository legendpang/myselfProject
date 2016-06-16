//
//  DetailPlaceCell.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pushToMap <NSObject>

-(void)pushMapPlace;

@end




@interface DetailPlaceCell : UITableViewCell <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *imageScorllView;
@property (strong, nonatomic) IBOutlet UIPageControl *imagePageControl;
@property (strong, nonatomic) IBOutlet UILabel *adrLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *labelScrollView;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
- (IBAction)mapButton:(id)sender;
@property(nonatomic,assign)id<pushToMap>delegate;

@property(nonatomic,strong)NSArray * arrayImage;


-(void)creatImageView:(NSArray *)arr;
@end
