//
//  StarView.m
//  LoveLimitApp
//
//  Created by 潘颖超 on 15/10/8.
//  Copyright © 2015年 Meakelra. All rights reserved.
//

#import "StarView.h"

@implementation StarView

//<31>重写init方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
//<31.1>实现方法
- (void)creatUI{
    //灰色
    _backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 23)];
    _backgroundImage.image = [UIImage imageNamed:@"StarsBackground.png"];
    [self addSubview:_backgroundImage];
    
    //橘色
    _foregroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 23)];
    _foregroundImage.image = [UIImage imageNamed:@"StarsForeground.png"];
    [self addSubview:_foregroundImage];
    
    //切割视图
    _foregroundImage.clipsToBounds = YES;
    
    //图片的停靠关系:左对齐
    _foregroundImage.contentMode = UIViewContentModeLeft;
    
}
//<32>实现星级的设置：橘色的大小设置
- (void)setStarLevel:(NSString *)level{
    //level.floatValue  将字符串转为float
    //_backgroundImage.frame.size.width * level.floatValue / 5   重新设置橘色的宽度
    _foregroundImage.frame = CGRectMake(0, 0, _backgroundImage.frame.size.width * level.floatValue / 5, 23);
}


@end
