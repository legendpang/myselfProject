//
//  RootTabBarViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "RootNavigationViewController.h"
#import "RootViewController.h"
#import "Header.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController
{
    NSMutableArray * _VCArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViewControllers];
    
}

-(void)createViewControllers
{
    _VCArray = [[NSMutableArray alloc]initWithCapacity:4];
    for (int i=0; i<4; i++) {
        RootViewController * rvc = [[NSClassFromString([Controller_Array objectAtIndex:i]) alloc] initWithTitle:[Navition_Title objectAtIndex:i] tabTitle:[TabBar_Title objectAtIndex: i] tabImage:TabBar_Image[i] andSelectImage:TabBar_SelectImage[i]];
        RootNavigationViewController * rnvc = [[RootNavigationViewController alloc]initWithRootViewController:rvc];
        [_VCArray addObject:rnvc];
    }
    
    self.viewControllers = _VCArray;
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
