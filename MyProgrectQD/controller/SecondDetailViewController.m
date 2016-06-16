//
//  SecondDetailViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SecondDetailViewController.h"
#import "SecondDetailCell.h"
#import "SecondDetailModel.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface SecondDetailViewController ()

@end

@implementation SecondDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"SecondDetailViewController--->%@",_iid);
    self.tableView.footer = nil;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    self.urlStr = url5;
    [self.tableView.header beginRefreshing];
    
   
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondDetailCell" bundle:nil] forCellReuseIdentifier:@"secondDetail"];
}

-(void)downRefresh
{
    
    NSString * strUrl = [NSString stringWithFormat:self.urlStr,[self.iid intValue]];
    
    [self statrRequest:strUrl AndTag:1];
}

-(void)statrRequest:(NSString *)url AndTag:(NSInteger)tag
{
    
    [Net getHttpURL:url completation:^(id object) {
        if (tag == 1) {
            [self.dataArray removeAllObjects];
            [self loadData:object];
            
            
            
        }
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    } andType:@"json"];
    
}

-(void)upRefresh
{
    
}
-(void)loadData:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]]) {
        SecondDetailModel * model = [[SecondDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:object];
        [self.dataArray addObject:model];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondDetailModel * model = self.dataArray[indexPath.row];
    NSString *string = model.content;
    
   
    CGRect frame = [string boundingRectWithSize:CGSizeMake(WIDTH - 100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
  
    
    return frame.size.height + 50;
    
    //return 600;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"secondDetail" forIndexPath:indexPath];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SecondDetailModel * model = self.dataArray[indexPath.row];
    cell.headLabel.text = model.title;
    cell.timeLabel.text = model.regtime;
    //[cell.desDetailLabel sizeToFit];
    
    cell.desDetailLabel.text = model.content;
    
    return cell;
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
