//
//  MyNavigationBar.m
//  MyProgrectQD
//
//  Created by Dalang on 16/9/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "MyNavigationBar.h"
#define iViewWidth [[UIScreen mainScreen] bounds].size.width
#define iViewHeight [[UIScreen mainScreen] bounds].size.height
//字号
#define titleFont 18.0f
@implementation MyNavigationBar

-(instancetype)initWithTitle:(NSString *)title withColor:(UIColor *)color{
    self = [super init];
    
    if (self) {
        self.frame = CGRectMake(0, 0, iViewWidth, 64);
        self.backgroundColor = color;
        [self setTitleLabel:title];
        if ([color isEqual:[UIColor whiteColor]]) {
            //设置分割线
            UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, iViewWidth, 1)];
            lineLabel.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineLabel];
        }
       
    }
    return self;
}
//set titleLabel
-(void)setTitleLabel:(NSString *)titleName{
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:titleFont];
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = fnt;
    titleLabel.numberOfLines = 0;
    titleLabel.text = titleName;
    titleLabel.textColor = [UIColor purpleColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    //根据文字内容多少计算label的frame
    CGSize size = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    // 名字的H
    CGFloat titleH = size.height;
    // 名字的W
    CGFloat titleW = size.width;
    
    titleLabel.frame = CGRectMake((iViewWidth-titleW)/2, (64-titleH)/2, titleW, titleH);
    [self addSubview:titleLabel];

}
-(void)setGoBackButton{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 12, 50, 40);
    [button setTitle:@"<返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [self addSubview:button];

}
-(void)backClick:(UIButton *)btn
{
    if (_delegate!=nil&&[_delegate respondsToSelector:@selector(myNavigationGoback)]) {
        [_delegate myNavigationGoback];
    }
}
@end
