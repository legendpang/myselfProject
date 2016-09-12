//
//  RootViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
//http://mtravel.qingdaonews.com/index.php?map_x=40.035683&page=1&order=2&class=%E6%8E%92%E5%BA%8F&map_y=116.364182&key=&r=mobile/view/list
#import "RootViewController.h"

@interface RootViewController ()<UIGestureRecognizerDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.automaticallyAdjustsScrollViewInsets = NO;
#pragma mark---隐藏导航栏属性(隐藏之后可以使用自定义的导航栏来替换)；
    self.navigationController.navigationBarHidden = YES;
    //设置右滑返回{注意添加代理----->UIGestureRecognizerDelegate}
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //字体颜色
    self.tabBarController.tabBar.tintColor = [UIColor purpleColor];
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:208/255.0 green:223/255.0 blue:185/255.0 alpha:1.0];
    _page = 2;
    _dataArray = [[NSMutableArray alloc]init];
    [self createTableView];
    [self createMJRefreshUI];
    
}

-(void)createMJRefreshUI
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}
-(void)downRefresh
{
    
    
    NSString * strUrl = [NSString stringWithFormat:self.urlStr,1];
    
    [self statrRequest:strUrl AndTag:1];
}
-(void)upRefresh
{
   
    NSString * strUrl = [NSString stringWithFormat:self.urlStr,_page++];
   [self statrRequest:strUrl AndTag:2];
}
-(void)statrRequest:(NSString *)url AndTag:(NSInteger)tag
{
    [Net getHttpURL:url completation:^(id object) {
        if (tag == 1) {
            [_dataArray removeAllObjects];
            [self loadData:object];
            _page = 2;
        }else if(tag == 2){
            
            [self loadData:object];
            
        }
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    } failure:^(NSError *error) {
      
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络链接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
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
           
            [_dataArray addObject:model];
        }
       
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    return nil;
}

- (instancetype)initWithTitle:(NSString *)title tabTitle:(NSString *)tabTitle tabImage:(NSString *)image andSelectImage:(NSString *)selectImage
{
    if (self = [super init]) {
        //
        self.title = title;
        //
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:tabTitle image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectImage]];
        
    }
    return self;
}
- (void)createBarButtonLeftTitle:(NSString *)leftTitle LeftImage:(NSString *)leftImage RightTitle:(NSString *)rightTitle RightImage:(NSString *)rightImage
{
    if (leftTitle != nil) {
        self.navigationItem.leftBarButtonItem = [Function barButtonTitle:leftTitle Image:leftImage Target:self Sel:@selector(leftBarButtonClick:)];
    }
    if (rightTitle != nil) {
        self.navigationItem.rightBarButtonItem = [Function barButtonTitle:rightTitle Image:rightTitle Target:self Sel:@selector(rightBarButtonClick:)];
    }
}
-(void)rightBarButtonClick:(UIBarButtonItem *)btn
{
    
}
-(void)leftBarButtonClick:(UIBarButtonItem *)btn
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
