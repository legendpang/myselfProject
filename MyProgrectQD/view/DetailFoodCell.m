//
//  DetailFoodCell.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailFoodCell.h"
#import "UIImageView+WebCache.h"
@implementation DetailFoodCell

- (void)awakeFromNib {
    
   // NSLog(@"<----|||>%f",_imageScrollView.frame.size.width);
    _imageScrollView.bounces = NO;
    _imageScrollView.delegate = self;
    _imageScrollView.pagingEnabled = NO;
}

-(void)creatImageView:(NSArray *)arr
{
    for (int i = 0; i<arr.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_imageScrollView.frame.size.width, 0, _imageScrollView.frame.size.width, _imageScrollView.frame.size.height)];
      
        [imageView sd_setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:[UIImage imageNamed:@"qd_urlunload"]];
        [_imageScrollView addSubview:imageView];
    }
    _imageScrollView.contentSize = CGSizeMake(_imageScrollView.frame.size.width * arr.count, _imageScrollView.frame.size.height);
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.bounces = NO;
    _pageControl.numberOfPages = arr.count;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = _imageScrollView.contentOffset;
    int i = point.x / _imageScrollView.frame.size.width;
    _pageControl.currentPage = i;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mapClick:(id)sender {
    
    [self.delegate pushMapPlace];
    
    
}
@end
