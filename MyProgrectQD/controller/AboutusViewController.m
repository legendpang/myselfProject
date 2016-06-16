//
//  AboutusViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AboutusViewController.h"
#import "AboutusCell.h"
@interface AboutusViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView * tabelView;


@end

@implementation AboutusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.navigationItem.title = _headTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    _tabelView.delaysContentTouches = NO;
    [self creatTableViewUI];
    [_tabelView registerNib:[UINib nibWithNibName:@"AboutusCell" bundle:nil] forCellReuseIdentifier:@"about"];
    
}
-(void)creatTableViewUI
{
    _dataArray = [[NSMutableArray alloc] init];
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    [self.view addSubview:_tabelView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutusCell * cell = [tableView dequeueReusableCellWithIdentifier:@"about" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.airLabel.text = @"即便是在盛夏,海边的昼夜温差也比较大,因此晚上出来吹海风,一定要做好保暖工作";
    cell.cleanLabel.text = @"青岛以环境优美著称,道路整洁,沙滩明净,因此在这里旅游一定要注意爱护公共卫生,不要乱扔垃圾";
    cell.trafficLabel.text = @"青岛的出租车存在不规范行为.建议避免搭乘在火车站,汽车站趴活的出租车.机场乘坐出租车,注意保存上车时督导员给予的乘车卡,遇到问题直接投诉,避免在车上争吵.旺季在景点几乎不可能打到车,建议查询公交路线,青岛的公共交通非常方便.";
    cell.seaLabel.text = @"在沙滩戏水或礁石玩耍的时候,注意手机和相机要放好,不要掉进水中.";
    cell.foodLabel.text = @"青岛人几乎不会去海边吃饭,海边的餐馆几乎是面对游客的.在景区的饭馆,可以要求点完菜后,下单前先结账,这样可以避免不必要的纠纷.";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 640;
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
