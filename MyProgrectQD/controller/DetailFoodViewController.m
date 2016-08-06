//
//  DetailFoodViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailFoodViewController.h"
#import "DetailFoodCell.h"
#import "YC_FMDBManager.h"
#import "DetailFoodModel.h"
#import "CollectionViewController.h"
#import "AppDelegate.h"

static NSString * iden = @"id";

@interface DetailFoodViewController ()<pushToFoodMap>

@end

@implementation DetailFoodViewController

{
    UIButton * _button;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    YC_FMDBManager * manager = [YC_FMDBManager shareManager];
    NSArray * array = [manager allPersonInfos];
    for (PlaceModel * model in array) {
        // NSLog(@"model.name-----%@",model.name);
        if ([model.name isEqualToString:_name]) {
            [_button setTitle:@"已收藏" forState:UIControlStateNormal];
        }
    }
    // NSLog(@"_name-----%@",_name);
    [self.tableView.header beginRefreshing];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _name;
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 -49 -30) ;
    [self creatCollectionButton];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.delaysContentTouches = NO;
    self.tableView.footer = nil;
    
  
    self.urlStr = url7;
    [self.tableView.header beginRefreshing];
    
    
    //*加定时器原因:解决屏幕适配尺寸问题  */
     [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(requestData) userInfo:nil repeats:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailFoodCell" bundle:nil] forCellReuseIdentifier:iden];
    
}
-(void)requestData
{
    
    [self.tableView.header beginRefreshing];
}
-(void)creatCollectionButton
{
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _button.frame = CGRectMake(0, self.view.frame.size.height -49 -45, self.view.frame.size.width, 40);
    //_button.backgroundColor = [UIColor redColor];
    [_button setBackgroundImage:[UIImage imageNamed:@"qd_total"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(collectionButtonM:) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:@"收藏" forState:UIControlStateNormal];
    
    [self.view addSubview:_button];
}



-(void)downRefresh
{
    
    NSString * strUrl = [NSString stringWithFormat:self.urlStr,[self.xid intValue]];
    
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
        DetailFoodModel * model = [[DetailFoodModel alloc]init];
        [model setValuesForKeysWithDictionary:object];
        [self.dataArray addObject:model];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 480;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.tableView.header beginRefreshing];
    
    DetailFoodCell * cell = [tableView dequeueReusableCellWithIdentifier:iden forIndexPath:indexPath];
    for (UIView * view in cell.imageScrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    DetailFoodModel * model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.timeLabel.text = model.time;
    cell.adressLabel.text = model.address;
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@RMB起",model.money];
    cell.delegate = self;
   
    [cell creatImageView:model.images];
    
   // NSLog(@"<---->%f",cell.imageScrollView.frame.size.width);
    
    return cell;
    //[self.tableView reloadData];
}

-(void)collectionButtonM:(UIButton *)buttn
{
    if ([_button.currentTitle isEqualToString:@"已收藏"]) {
        return;
    }
      // NSLog(@"_myapp.tag-------%@",_myapp.tag);
   
    YC_FMDBManager * manager = [YC_FMDBManager shareManager];
    NSArray * array = [manager allPersonInfos];
    //[manager insertInfo:_myapp andID:array.count+1];
    [_button setTitle:@"已收藏" forState:UIControlStateNormal];
    
    
}

-(void)pushMapPlace
{
    DetailFoodModel * model = [self.dataArray lastObject];
    
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    app.map_x = model.map_x;
    app.map_y = model.map_y;
    app.name = _name;
    self.tabBarController.selectedIndex = 2;
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
