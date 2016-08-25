//
//  CollectionViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CollectionViewController.h"
#import "YC_FMDBManager.h"
#import "PlaceModel.h"
#import "UIImageView+WebCache.h"
#import "DetailPlaceViewController.h"
#import "DetailFoodViewController.h"
#import "AppDelegate.h"
#import "FoodModel.h"
#import "DataFactory.h"
#import "CompanyModel.h"
@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * xdataArray;

@property(nonatomic,assign)NSInteger tag;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DataFactory* df = [DataFactory shardDataFactory];
    [df CreateDataBase];
    [df CreateTable];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.navigationItem.title = _headTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick:)];
    [self creatTableViewUI];
 
}
-(void)rightClick:(UIBarButtonItem *)button
{
    CompanyModel * modle= [[CompanyModel alloc] init];
    modle.shortName = @"foewjfoewjfow";
    modle.orgid = @"8100001";
    [[DataFactory shardDataFactory] insertToDB:modle Classtype:company];
    [_tableView reloadData];
}

-(void)creatTableViewUI
{
    _xdataArray = [[NSMutableArray alloc]init];
   // YC_FMDBManager * manager = [YC_FMDBManager shareManager];
//    NSArray * array = [manager allPersonInfos];
//    for (PlaceModel * model in array) {
//        [_xdataArray addObject:model];
//    }
  //  NSLog(@"%@",array);
   // _xdataArray = [NSMutableArray arrayWithArray:array];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
}

#pragma mark ---delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _xdataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden = @"iden";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    PlaceModel * model = _xdataArray[indexPath.row];
   // NSLog(@"555555---%@",model.tag);
   // NSLog(@"%@",model.name);
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.characteristic;
    cell.detailTextLabel.numberOfLines = 1;
   [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"my_collection"]];
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PlaceModel * model = _xdataArray[indexPath.row];
    //AppDelegate * app = [[UIApplication sharedApplication] delegate];

   
   // NSLog(@"------%@",model.tag);
    if ([model.tag isEqualToString:@"food"]) {
        DetailFoodViewController * food = [[DetailFoodViewController alloc] init];
        food.xid = model.iId;
       // NSLog(@"******%@",model.iId);
        food.name = model.name;
        [self.navigationController pushViewController:food animated:YES];
    }else if ([model.tag isEqualToString:@"place"]){
        DetailPlaceViewController * det = [[DetailPlaceViewController alloc]init];
        det.xid = model.cid;
        det.name = model.name;
        // NSLog(@"%@",_xdataArray);
        [self.navigationController pushViewController:det animated:YES];
    }
   
    
    
    
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PlaceModel * model = _xdataArray[indexPath.row];
        [_xdataArray removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        YC_FMDBManager * manager = [YC_FMDBManager shareManager];
        [manager deletePersonInfo:model.name];
    }
    //[_tableView reloadData];
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
