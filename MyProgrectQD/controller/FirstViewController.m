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
    MyNavigationBar * mynav = [[MyNavigationBar alloc] initWithTitle:@"首页" withColor:[UIColor whiteColor]];
    [self.view addSubview:mynav];
    //[self textLabel];
}
-(void)textLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 30, 300, 20);
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] init];
    
    NSTextAttachment *imageStr = [[NSTextAttachment alloc]init];
    
    imageStr.image = [UIImage imageNamed:@"am"];
    
    imageStr.bounds = CGRectMake(0, 0, 20, 20);
    
    NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment:imageStr];
    [strM appendAttributedString:[[NSAttributedString alloc] initWithString:@"大家好"]];
    [strM appendAttributedString:attrString];
    [strM appendAttributedString:[[NSAttributedString alloc] initWithString:@"如果你是我的传说"]];
    label.attributedText = strM;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0],NSFontAttributeName, nil];
    CGRect contentRect = [strM.string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    label.frame = CGRectMake(0, 30, contentRect.size.width, contentRect.size.height);
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
