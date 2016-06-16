//
//  DetailPlaceViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailPlaceViewController.h"
#import "DetailPlaceCell.h"
#import "DetailPlaceModel.h"
#import "CollectionViewController.h"
#import "YC_FMDBManager.h"
#import "CollectionViewController.h"
#import "SDCycleScrollView.h"
#import "AppDelegate.h"

static NSString * detail = @"detail";
@interface DetailPlaceViewController () <UIScrollViewDelegate,pushToMap>

@end

@implementation DetailPlaceViewController
{
    UIButton * _button;
    //UIButton * _buttonShare;
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _name;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 -49 -30) ;
    [self creatCollectionButton];
    //self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delaysContentTouches = NO;
    self.tableView.footer = nil;
    
     self.urlStr = url3;
     [self.tableView.header beginRefreshing];
     [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(requestData) userInfo:nil repeats:NO];
   // [self.tableView registerNib:[UINib nibWithNibName:@"DetailPlaceCell" bundle:nil] forCellReuseIdentifier:detail];
    
}

-(void)requestData
{
    [self.tableView.header beginRefreshing];
   // NSLog(@"NNNNNN");
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
        DetailPlaceModel * model = [[DetailPlaceModel alloc]init];
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
    return 500;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailPlaceCell * cell = [tableView dequeueReusableCellWithIdentifier:detail];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailPlaceCell" owner:nil options:nil] lastObject];
       
    }else{
        for (UIView * view in cell.labelScrollView.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                [view removeFromSuperview];
            }
        }
        for (UIView * view in cell.imageScorllView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
      
    }
   
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    DetailPlaceModel * model = self.dataArray[indexPath.row];
    
    cell.phoneLabel.text = [NSString stringWithFormat:@"联系电话:%@",model.phone];
    cell.adrLabel.text = model.address;
    cell.timeLabel.text = model.time;
    [cell creatImageView:model.images];
   
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.labelScrollView.frame.size.width,cell.labelScrollView.frame.size.height)];
    
    label.text = model.introduction;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14.0];
    [label sizeToFit];
    
    [cell.labelScrollView addSubview:label];
    cell.labelScrollView.contentSize = CGSizeMake(label.frame.size.width, label.frame.size.height);
    
    return cell;
}


-(void)collectionButtonM:(UIButton *)buttn
{
    
    if ([_button.currentTitle isEqualToString:@"已收藏"]) {
        return;
    }
   
    YC_FMDBManager * manager = [YC_FMDBManager shareManager];
    NSArray * array = [manager allPersonInfos];
    [manager insertInfo:_myapp andID:array.count+1];
    [_button setTitle:@"已收藏" forState:UIControlStateNormal];
    
    
}
-(void)pushMapPlace
{
    DetailPlaceModel * model = [self.dataArray lastObject];
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    app.map_x = model.map_x;
    app.map_y = model.map_y;
    app.name = _name;
    
    self.tabBarController.selectedIndex = 2;
    
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
