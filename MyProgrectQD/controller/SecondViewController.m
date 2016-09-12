//
//  SecondViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondDetailViewController.h"
#import "SecondCell.h"
#import "MyNavigationBar.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    MyNavigationBar * mynav = [[MyNavigationBar alloc] initWithTitle:@"历史文化" withColor:[UIColor blueColor]];
    [self.view addSubview:mynav];
    self.page = 1;
    self.urlStr = url4;
    [self.tableView.header beginRefreshing];
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondCell" bundle:nil] forCellReuseIdentifier:@"second"];
    
}
-(void)downRefresh
{
    
    
    NSString * strUrl = [NSString stringWithFormat:self.urlStr,0];
    
    [self statrRequest:strUrl AndTag:1];
}

-(void)upRefresh
{
    NSString * strUrl = [NSString stringWithFormat:self.urlStr,self.page++];
    [self statrRequest:strUrl AndTag:2];
}
-(void)statrRequest:(NSString *)url AndTag:(NSInteger)tag
{
    [Net getHttpURL:url completation:^(id object) {
        if (tag == 1) {
            [self.dataArray removeAllObjects];
            [self loadData:object];
            self.page = 1;
        }else if(tag == 2){
            
            [self loadData:object];
            
        }
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    } andType:@"json"];
    
    
    
}

-(void)loadData:(id)object
{
    if ([object isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary * dic in object) {
            PlaceModel * model = [[PlaceModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"second" forIndexPath:indexPath];
    
    PlaceModel * model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.desLabel.text = model.des;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlaceModel * model = self.dataArray[indexPath.row];
    SecondDetailViewController * secondDetail = [[SecondDetailViewController alloc]init];
    secondDetail.iid = model.iid;
    [self.navigationController pushViewController:secondDetail animated:YES];
    
    
    
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
