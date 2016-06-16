//
//  FoodViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FoodViewController.h"
#import "PlacefViewCell.h"
#import "DetailFoodViewController.h"
#import "StarView.h"

static NSString * place = @"pla";
@interface FoodViewController ()<UISearchBarDelegate>
@property(nonatomic,strong)NSString * food;
@property(nonatomic,strong)NSMutableArray * resultArray;
@property(nonatomic,strong)UISearchBar * searchBar;
@property(nonatomic,strong)UISearchDisplayController * sdc;


@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _food = @"food";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"娱乐天地";
    _resultArray = [[NSMutableArray alloc] init];
    self.urlStr = url6;
    [self.tableView.header beginRefreshing];
    [self createSearchUI];
    // Do any additional setup after loading the view.
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
   // NSString * url = @"http://mtravel.qingdaonews.com/index.php?type=1&map_x=40.035837&page=2&order=2&class=0&map_y=116.364124&key=&r=mobile/topicInfo/index";
 NSString * strUrl = [NSString stringWithFormat:self.urlStr,1];
    
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
            self.page = 2;
        }else if(tag == 2){
            
            [self loadData:object];
            
        }
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
       // NSLog(@"%@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"抱歉,没有更多娱乐天地啦!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //展示UIAlertView@
        [alertView show];
        
        
        
    } andType:@"json"];
    
    
    
}
-(void)loadData:(id)object
{
    if ([object isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary * dic in object) {
            PlaceModel * model = [[PlaceModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            model.iId = [dic objectForKey:@"id"];
            // model.tag = @"place";
            [self.dataArray addObject:model];
        }
        
        
    }
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
    DetailFoodViewController * detail = [[DetailFoodViewController alloc] init];
    
    detail.myapp = model;
    detail.myapp.tag = @"food";
    detail.name = model.name;
    detail.xid = model.iId;
    
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
