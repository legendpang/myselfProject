//
//  WelcomeViewController.m
//  MyProgrectQD
//
//  Created by apple on 15/11/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RootTabBarViewController.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIButton * startButton;//立即启用按钮
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * array = @[@"qd1.jpg",@"qd3.jpg",@"qd2.jpg"];
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height);
    [self.view addSubview:scrollView];
    for (int i = 0; i<3; i++) {
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageview.image = [UIImage imageNamed:array[i]];
        
        [scrollView addSubview:imageview];
    }

    scrollView.pagingEnabled = YES;
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.hidden = YES;
    _startButton.frame = CGRectMake((self.view.frame.size.width-80)/2, self.view.frame.size.height-60, 80, 40);
    [_startButton setTitle:@"立即启用" forState:UIControlStateNormal];
    _startButton.backgroundColor = [UIColor lightGrayColor];
    [_startButton addTarget:self action:@selector(jumpMainVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
}
- (void)jumpMainVC:(UIButton *)btn
{
    RootTabBarViewController * tabVC = [[RootTabBarViewController alloc] init];
    [self presentViewController:tabVC animated:NO completion:^{
        
    }];
}
//通过scrollview代理方法来判断当前页面滑动到第几页，如果为第三页就将“立即启用”的按钮显示，否则不显示
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint contoffNum = scrollView.contentOffset;
    NSLog(@"%f",contoffNum.x);
    if (contoffNum.x == self.view.frame.size.width * 2) {
        _startButton.hidden = NO;
    }else{
        _startButton.hidden = YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
