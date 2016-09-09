//
//  FirstViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstMCell.h"
#import "PlaceViewController.h"
#import "FoodViewController.h"
#import "MyNavigationBar.h"
@interface FirstViewController () <ChangeViewControll>

@end

@implementation FirstViewController
-(void)changeViewControllWithTag:(NSInteger)tag
{
    PlaceViewController * plc = [[PlaceViewController alloc]init];
    FoodViewController * food = [[FoodViewController alloc] init];
    
    if (tag == 1) {
        [self.navigationController pushViewController:plc animated:YES];
    }else if (tag == 2){
        [self.navigationController pushViewController:food animated:YES];
    }
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.footer = nil;
    self.tableView.header = nil;
    self.tableView.scrollEnabled = YES;
    MyNavigationBar * mynav = [[MyNavigationBar alloc] initWithTitle:@"首页" withColor:[UIColor blueColor]];
    [self.view addSubview:mynav];
        
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 554;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstMCell * cell = [tableView dequeueReusableCellWithIdentifier:@"firstm"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FirstMCell" owner:nil options:nil] lastObject];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
