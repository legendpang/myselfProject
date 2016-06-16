//
//  FirstMCell.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeViewControll <NSObject>

-(void)changeViewControllWithTag:(NSInteger)tag;

@end


@interface FirstMCell : UITableViewCell <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
- (IBAction)place:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *foodButton;

- (IBAction)foodButton:(id)sender;

@property (nonatomic,assign)id<ChangeViewControll>delegate;

@end
