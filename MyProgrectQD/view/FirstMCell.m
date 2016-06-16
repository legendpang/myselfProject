//
//  FirstMCell.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FirstMCell.h"

@implementation FirstMCell
{
    UIImageView * _imageView;
}
-(void)layoutSubviews
{
    NSArray * array = @[@"qd1.jpg",@"qd3.jpg",@"qd2.jpg"];
    for (int i =0 ; i<3; i++) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_imageScrollView.frame.size.width, 0, _imageScrollView.frame.size.width, _imageScrollView.frame.size.height)];
        
        //  NSLog(@"000--000---%f",_imageScrollView.frame.size.width);
        _imageView.image = [UIImage imageNamed:array[i]];
        [_imageScrollView addSubview:_imageView];
        
    }
    ////////
    //    _imageScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    //    NSDictionary *contraintDict = NSDictionaryOfVariableBindings(_imageView);
    //    NSArray *contraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_imageView]-0-|" options:0 metrics:nil views:contraintDict];
    //    [_imageScrollView addConstraints:contraints1];
    
    ///////
    _imageScrollView.delegate = self;
    _imageScrollView.bounces = NO;
    
    _imageScrollView.contentSize = CGSizeMake(_imageScrollView.frame.size.width*3, _imageScrollView.frame.size.height);
    _imageScrollView.pagingEnabled = YES;
    [self.backView addSubview:_pageControl];
    //添加定时器做图片轮播
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];
    
}

- (void)awakeFromNib {
   
  
}

-(void)changeOffset
{
    CGPoint point = _imageScrollView.contentOffset;
   // point.x = width;
 
    point.x = point.x + _imageScrollView.frame.size.width;
    if (point.x == _imageScrollView.frame.size.width * 3) {
        point.x = 0;
    }
    _imageScrollView.contentOffset = point;
    int i = point.x / _imageScrollView.frame.size.width;
    _pageControl.currentPage = i;
   // NSLog(@"123");
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /*改变pageControl放到定时器的方法中区*/
    
    
//    CGPoint point = _imageScrollView.contentOffset;
//    int i = point.x / _imageScrollView.frame.size.width;
//    _pageControl.currentPage = i;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)place:(id)sender {
    [self.delegate changeViewControllWithTag:1];
    
}
- (IBAction)foodButton:(id)sender {
    [self.delegate changeViewControllWithTag:2];
}
@end
