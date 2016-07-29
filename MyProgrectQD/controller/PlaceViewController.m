//
//  PlaceViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PlaceViewController.h"
#import "PlacefViewCell.h"
#import "DetailPlaceViewController.h"
#import "StarView.h"
#import "MyNavigationBar.h"
static NSString * place = @"123";

@interface PlaceViewController ()<UISearchDisplayDelegate>
@property(nonatomic,strong)NSString * place;
@property(nonatomic,strong)NSMutableArray * resultArray;
@property(nonatomic,strong)UISearchBar * searchBar;
@property(nonatomic,strong)UISearchDisplayController * sdc;

@end

@implementation PlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _place = @"place";
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"景区景点";
//    MyNavigationBar * mynav = [[MyNavigationBar alloc]init];
//    mynav.frame = self.navigationController.navigationBar.frame;
//    [self.navigationController.navigationBar addSubview:mynav];
    _resultArray = [[NSMutableArray alloc] init];
    self.urlStr = testUrl;
    [self.tableView.header beginRefreshing];
   
    [self createSearchUI];
    
    
}

-(void)createSearchUI
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _searchBar.placeholder = @"请输入要查询景点的名字";
    self.tableView.tableHeaderView = _searchBar;
    _sdc = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _sdc.searchResultsDelegate = self;
    _sdc.searchResultsDataSource = self;
    _sdc.delegate = self;
    
    
}
-(void)downRefresh
{
    NSString * urla = @"%E6%8E%92%E5%BA%8F";
    NSString * sr = [urla stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * strUrl = [NSString stringWithFormat:self.urlStr,1,sr];
    
    [self statrRequest:strUrl AndTag:1];
}


-(void)upRefresh
{
    NSString * urla = @"%E6%8E%92%E5%BA%8F";
    NSString * sr = [urla stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * strUrl = [NSString stringWithFormat:self.urlStr,self.page++,sr];
    [self statrRequest:strUrl AndTag:2];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView != self.tableView) {
        return _resultArray.count;
    }
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlacefViewCell * cell = [tableView dequeueReusableCellWithIdentifier:place];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PlacefViewCell" owner:nil options:nil] lastObject];
    }
    if (tableView != self.tableView) {
        PlaceModel * model  = _resultArray[indexPath.row];
        cell.nameLabel.text = model.name;
        cell.specialLabel.text = [NSString stringWithFormat:@"特色:%@",model.characteristic];
        cell.distanceLabel.text = [NSString stringWithFormat:@"%@ 公里",model.distance];
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"image_back"]];
        [cell.startView setStarLevel:model.score];
        
    }else{
        
    PlaceModel * model  = self.dataArray[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.specialLabel.text = [NSString stringWithFormat:@"特色:%@",model.characteristic];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%@ 公里",model.distance];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"image_back"]];
        [cell.startView setStarLevel:model.score];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceModel * model = self.dataArray[indexPath.row];
   // NSLog(@"%@",model.cid);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailPlaceViewController * detail = [[DetailPlaceViewController alloc] init];
    detail.xid = model.cid;
    detail.myapp = model;
    detail.myapp.tag = @"place";
   // model.tag = 1;
    detail.name = model.name;
 
    [self.navigationController pushViewController:detail animated:YES];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [_resultArray removeAllObjects];
    for (PlaceModel * model in self.dataArray) {
        NSRange range = [model.name rangeOfString:searchString];
       // NSRange range1 = [model.characteristic rangeOfString:searchString];
        if (range.length != 0) {
            [_resultArray addObject:model];
        }
    }
    return YES;
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
