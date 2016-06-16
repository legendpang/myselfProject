//
//  DetailPlaceCell.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailPlaceCell.h"
#import "PlaceModel.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "YC_FMDBManager.h"

@implementation DetailPlaceCell 


- (void)awakeFromNib {
    
    
    
    _imageScorllView.delegate = self;
    _imageScorllView.bounces = NO;
    _imageScorllView.pagingEnabled = YES;
}

-(void)creatImageView:(NSArray *)arr
{
    for (int i = 0; i<arr.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_imageScorllView.frame.size.width, 0, _imageScorllView.frame.size.width, _imageScorllView.frame.size.height)];
       // NSLog(@"111--111---%f",_imageScorllView.frame.size.width);
        [imageView sd_setImageWithURL:[NSURL URLWithString:arr[i]]];
        
        [_imageScorllView addSubview:imageView];
    }
    _imageScorllView.contentSize = CGSizeMake(_imageScorllView.frame.size.width * arr.count, _imageScorllView.frame.size.height);
    _imageScorllView.pagingEnabled = YES;
    _imageScorllView.bounces = NO;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = _imageScorllView.contentOffset;
    int i = point.x / _imageScorllView.frame.size.width;
    _imagePageControl.currentPage = i;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)pushjingdu
{
    
}


- (IBAction)mapButton:(id)sender {
    [self.delegate pushMapPlace];
    
}
@end
